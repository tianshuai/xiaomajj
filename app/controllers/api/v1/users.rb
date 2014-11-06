module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults

      helpers do
        def create_captcha_phone(phone_number, options={})
          captcha = Captcha.new(options)
          if captcha.save
            UserSms.captcha_sms({phone: phone_number, captcha: options[:code]})
            return { stat: 1, msg: 'success!' }
          else
            return { stat: 0, msg: '创建captcha失败' }
          end
        end

        def create_captcha_email(user, options={})
          captcha = Captcha.new(options)
          if captcha.save
            UserMailer.find_pwd(user, captcha.code).deliver
            return { stat: 1, msg: 'success!' }
          else
            return { stat: 0, msg: '创建captcha失败' }
          end
        end
      end

      resource :users do

        desc "Create a user."
        params do
          requires :mark, type: String, desc: "user email or phone"
          requires :login, type: String, desc: "user login"
          requires :password, type: String, desc: "user password"
        end
        post do
          if (User::VALID_EMAIL_REGEX =~ params[:mark]) == 0
            hash = {
              login: params[:login],
              email: params[:mark].downcase,
              password: params[:password]
            }
            return { stat: 0, msg: '邮箱已存在' } if User.have_email?(hash[:email])
          elsif (User::VALID_PHONE_REGEX =~ params[:mark]) == 0
            hash = {
              login: params[:login],
              phone: params[:mark].to_i,
              password: params[:password]
            }
            return { stat: 0, msg: '手机号已存在' } if User.have_phone?(hash[:phone])
          else
            return {stat: 0, msg: '邮箱或手机格式不正确!'}
          end
          user = User.new(hash)
          if user.save
            { stat: 1, msg: 'success!' }
          else
            { stat: 0, msg: '注册失败!' }
          end
        end

        desc "send code for emai"
        params do
          requires :email, type: String, desc: 'user email'
        end
        get :send_code_for_email do
          return { stat: 0, msg: '邮箱格式不正确' } unless (User::VALID_EMAIL_REGEX =~ params[:email]) == 0
          user = User.find_by(email: params[:email])
          return { stat: 0, msg: '邮箱不存在!' } unless user.present?

          captcha = Captcha.find_by( user_id: user.id, kind: Captcha::KIND[:email] )
          mark = Digest::MD5.hexdigest("#{user.email}:#{Time.now.to_i.to_s}")
          hash = {
            user_id: user.id,
            kind: Captcha::KIND[:email],
            code: mark,
            expires_at: Time.now.to_i
          }
          if captcha
            if captcha.is_expire_message?
              captcha.destroy
              create_captcha_email(user, hash)
            else
              return { stat: 0, msg: '操作过于频繁，稍后再试!' }
            end
          else
            create_captcha_email(user, hash)
          end
          
        end

        desc "send code for phone"
        params do
          requires :phone, type: String, desc: 'user phone'
        end
        get :send_code_for_phone do
          return { stat: 0, msg: '格式不正确' } if (User::VALID_PHONE_REGEX =~ params[:phone]) == nil
          user = User.find_by(phone: params[:phone])
          return { stat: 0, msg: '手机号不存在!' } unless user.present?
          captcha = Captcha.find_by( user_id: user.id, kind: Captcha::KIND[:phone] )
          hash = {
            user_id: user.id,
            kind: Captcha::KIND[:phone],
            code: Captcha.generate_phone_code,
            expires_at: Time.now.to_i
          }
          if captcha.present?
            if captcha.is_expire_message?
              captcha.destroy
              create_captcha_phone(user.phone, hash)
            else
              return { stat: 0, msg: '操作过于频繁，稍后再试!' }
            end
          else
            create_captcha_phone(user.phone, hash)
          end
          
        end

        desc 'find pwd email view'
        params do
          requires :code, type: String, desc: 'param mark'
        end
        get :find_pwd_view do
          captcha = Captcha.find_by(code: params[:code])
          return { stat: 0, msg: '验证无效!' } unless captcha.present?
          return { stat: 0, msg: '验证码失效,请重新发送邮件!' } if captcha.is_expire?
          user = User.find(captcha.user_id)
          return { stat: 0, msg: '用户不存在!' } unless user.present?
          { stat: 1, code: captcha.code, user_id: captcha.user_id, user_login: user.login }
        end

        desc "find pwd for email"
        params do
          requires :code, type: String, desc: 'param code'
          requires :password, type: String, desc: 'new password'
          requires :password_confirm, type: String, desc: 'confirm password'
        end
        post :find_pwd_for_email do
          captcha = Captcha.find_by(code: params[:code], kind: Captcha::KIND[:email])
          return { stat: 0, msg: '验证无效!' } unless captcha.present?
          return { stat: 0, msg: '验证码失效,请重新发送邮件!' } if captcha.is_expire?
          user = User.find(captcha.user_id)
          return { stat: 0, msg: '用户不存在!' } unless user.present?
          return { stat: 0, msg: '两次密码不一致' } if params[:password] != params[:password_confirm]
          if user.update(password: params[:password])
            captcha.destroy
            { stat: 1, msg: '更新成功!' }
          else
            { stat: 0, msg: '更新失败!' }
          end

        end

        desc "find pwd for phone"
        params do
          requires :phone, type: String, desc: 'user phone'
          requires :code, type: Integer,  desc: 'code'
          requires :password, type: String, desc: 'password'
          requires :password_confirm, type: String, desc: 'confirm password'
        end
        post :find_pwd_for_phone do
          return { stat: 0, msg: '手机格式不正确' } if (User::VALID_PHONE_REGEX =~ params[:phone]) == nil
          user = User.find_by(phone: params[:phone])
          return { stat: 0, msg: '手机号不存在!' } unless user.present?
          captcha = Captcha.find_by( user_id: user.id, kind: Captcha::KIND[:phone] )
          if captcha
            return { stat: 0, msg: '验证码不正确!' } if captcha.code.to_s != params[:code].to_s
            if captcha.is_expire?
              { stat: 0, msg: '验证码已过期!' }
            else
              return { stat: 0, msg: '两次密码不一致' } if params[:password] != params[:password_confirm]
              if user.update(password: params[:password])
                captcha.destroy
                { stat: 1, msg: '更新成功!' }
              else
                { stat: 0, msg: '更新失败!' }
              end
            end
          else
            { stat: 0, msg: '请重新验证!' }
          end
        end

      end
    end
  end
end
