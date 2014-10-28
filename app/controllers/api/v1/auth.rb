module API
  module V1
    class Auth < Grape::API
      include API::V1::Defaults
      resource :auth do

      desc "Creates and returns access_token if valid login"
      params do
         requires :login, type: String, desc: "email"
         requires :password, type: String, desc: "Password"
      end
      post :login do
        if params[:login].include?("@")
          user = User.find_by(email: params[:login].downcase)
        else
          user = nil
        end

        unless user
          return error!('邮箱不存在!', 401)
        end
        if user.authenticate(params[:password])
          key = ApiKey.create(user_id: user.id)
          {token: key.access_token, user_id: user.id, login: user.login}
        else
          error!('密码错误!', 401)
        end
      end

      desc "Returns pong if logged in correctly"
      params do
        requires :token, type: String, desc: "Access token."
      end
      get :ping do
        authenticate!
        { message: "ok" }
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
          error!('未登陆状态', 401)
        end
      end

      desc 'check_email'
      params do
        requires :email, type: String, desc: 'email'
      end
      get :check_email do
        #验证邮箱格式
        z = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
        unless z.match(params[:email])
          error!('邮箱格式不正确!', 401)
        end
        user = User.find_by(email: params[:email].downcase)
        if user
          error!('邮箱已存在!', 401)
        else
          {stat: 1, msg: '可以注册'}
        end
      end
    end  
  end
end
end
