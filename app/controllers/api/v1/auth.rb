module API
  module V1
    class Auth < Grape::API
      include API::V1::Defaults
      resource :auth do

      desc "Creates and returns access_token if valid login"
      params do
         requires :mark, type: String, desc: "user email or phone"
         requires :password, type: String, desc: "Password"
      end
      post :login do

        if (User::VALID_EMAIL_REGEX =~ params[:mark]) == 0
          user = User.find_by(email: params[:mark].downcase)
        elsif (User::VALID_PHONE_REGEX =~ params[:mark]) == 0
          user = User.find_by(phone: params[:mark])
        else
          return {stat: 0, msg: '邮箱或手机格式不正确!'}
        end
        if user.present?
          if user.authenticate(params[:password])
            key = ApiKey.create(user_id: user.id)
            { stat: 1, token: key.access_token, user_id: user.id, login: user.login }
          else
            { stat: 0, msg: '密码不正确' }
          end
        else
          { stat: 0, msg: '用户不存在' }
        end

      end

      desc "Returns pong if logged in correctly"
      params do
        requires :token, type: String, desc: "Access token."
      end
      get :ping do
        #authenticate!
        if current_user
          { stat: 1, msg: 'ok' } 
        else
          { stat: 0, msg: 'not login' } 
        end 
      end
  
      desc 'logout'
      params do
        requires :token, type: String, desc: 'Access token'
      end
      get :logout do
        if current_user
          self.current_user = nil
          
          {stat: 1, msg: 'success!'}
        else
          {stat: 0, msg: '未登陆状态!'}
        end
      end

      desc 'check_user email or phone'
      params do
        requires :mark, type: String, desc: 'user email or phone'
      end
      get :check_user do
        if (User::VALID_EMAIL_REGEX =~ params[:mark]) == 0
          return { stat: 0, msg: '邮箱已存在!' } if User.have_email?(params[:mark].downcase)
          
        elsif (User::VALID_PHONE_REGEX =~ params[:mark]) == 0
          return { stat: 0, msg: '手机已存在!' } if User.have_phone?(params[:mark])
        else
          return {stat: 0, msg: '邮箱或手机格式不正确!'}
        end
        {stat: 1, msg: '可以注册'}

      end
    end  
  end
end
end
