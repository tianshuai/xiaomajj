module API
  module V1
    class ThirdApies < Grape::API
      include API::V1::Defaults

      namespace :third do

        desc "video zhi bo."
        get :zhibo do
          url = 'http://appbg.xiaoma.com/open_courses.json'
          RestClient::Request.execute(:method => :get, :url => url, :timeout => 120, :open_timeout => 120)
        end


        namespace :wb do
          desc 'fetch weibo token'
          params do
            requires :code, type: String, desc: 'code'
          end
          get :fetch_third_token do
            url = 'https://api.weibo.com/oauth2/access_token'
            param = {
           		client_id: CONF['wb_api']['api_key'],
		          client_secret: CONF['wb_api']['api_sercet'],
		          grant_type: 'authorization_code',
		          code: params[:code],
		          redirect_uri: File.join(CONF['static_domain'], 'wb_callback.html')
            }
            #result = RestClient::Request.execute(:method => :post, :url => url, :timeout => 60, :open_timeout => 60)
            begin
              result = RestClient.post url, param
              result = JSON.parse(result)

              third_api = ThirdApi.where(uid: result['access_token'], kind: ThirdApi::KIND[:wb])
              if third_api.present? && third_api.first.user.present?
                key = ApiKey.new(user_id: third_api.first.user.id)
                if key.save
                  { stat: 2, token: key.access_token, user_id: user.id, login: user.login }
                else
                  { stat: 0, msg: '登录失败!' }
                end
              else
                { stat: 1, msg: 'ok', data: result }
              end
            rescue=>e
              { stat: 0, msg: e.message }
            end
          end

        end

        namespace :qq do
          desc 'fetch qq token'
          params do
            requires :code, type: String, desc: 'code'
          end
          get :fetch_third_token do
            url = 'https://graph.qq.com/oauth2.0/token'
            param = {
           		client_id: CONF['qq_api']['api_key'],
		          client_secret: CONF['qq_api']['api_sercet'],
		          grant_type: 'authorization_code',
		          code: params[:code],
		          redirect_uri: File.join(CONF['static_domain'], 'qq_callback.html')
            }

            begin
              result = RestClient.post url, param
              #result = JSON.parse(result)
              result.split('&').each do |d|
                d.split('=').each do |f|
                  f[0]
                end
              end
              puts 'bbbbb'
              puts result
          
            rescue=>e
              puts 'cccc'
              puts e.message
              { stat: 0, msg: e.message }
            end

          end
        end

      end
    end
  end
end
