module API
  module V1
    class ThirdApi < Grape::API
      include API::V1::Defaults

      resource :third_api do

        desc "video zhi bo."

        get 'zhibo' do
          url = 'http://appbg.xiaoma.com/open_courses.json'
          RestClient::Request.execute(:method => :get, :url => url, :timeout => 120, :open_timeout => 120)
        end

      end
    end
  end
end
