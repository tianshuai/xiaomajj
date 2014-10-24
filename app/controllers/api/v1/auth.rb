module API
  module V1
    class Auth < Grape::API
      include API::V1::Defaults
      resource :auth do

      desc "Creates and returns access_token if valid login"
      params do
         requires :login, type: String, desc: "Username or email address"
         requires :password, type: String, desc: "Password"
      end
      post :login do
        if params[:login].include?("@")
          user = User.find_by(email: params[:login].downcase)
        else
          user = nil
        end

        if user && user.authenticate(params[:password])
          key = ApiKey.create(user_id: user.id)
          {token: key.access_token, user_id: user.id, login: user.login}
        else
          error!('Unauthorized.', 401)
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
    end  
  end
end
end
