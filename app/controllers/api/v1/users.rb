module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults

      resource :users do

        desc "Create a user."
        params do
          requires :email, type: String, desc: "user email"
          requires :login, type: String, desc: "user login"
          requires :password, type: String, desc: "user password"
        end
        post do
          user = User.new({
            login: params[:login],
            email: params[:email],
            password: params[:password]
          })
          if user.save
            { stat: 1, msg: 'success' }
          else
            { stat: 0, msg: 'faile' }
          end
        end
      end
    end
  end
end