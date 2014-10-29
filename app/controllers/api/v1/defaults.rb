module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        prefix "api"
        version "v1", using: :path
        default_format :json
        format :json
        formatter :json, Grape::Formatter::ActiveModelSerializers

        helpers do
          def permitted_params
            @permitted_params ||= declared(params, include_missing: false)
          end

          def logger
            Rails.logger
          end
        end

        helpers do  
          def authenticate!
            error!('Unauthorized. Invalid or expired token.', 401) unless current_user
            
          end

          def load_user(options={})
            {user_info: user_info}.merge(options)
          end

          #用户基本信息
          def user_info
            {is_login: 0}
            if current_user
              {is_login: 1, id: current_user.id, name: current_user.login, email: current_user.email}
            end
          end

          def current_user=(user)
            @current_user = user
          end

          def current_user
          # find token. Check if valid.
            unless @current_user
              if cookies[:token].present?
                token = ApiKey.where(access_token: cookies[:token]).first
                if token && !token.expired?
                  @current_user ||= User.find(token.user_id)
                else
                  @current_user = nil
                end
              else
                @current_user = nil
              end
            end
            @current_user
          end
        end  

        rescue_from ActiveRecord::RecordNotFound do |e|
          error_response(message: e.message, status: 404)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          error_response(message: e.message, status: 422)
        end
      end
    end
  end
end
            
