module API
  module V1
    class Records < Grape::API
      include API::V1::Defaults

      resource :records do

        desc "Create a record."
        params do
          requires :audio_url, type: Rack::Multipart::UploadedFile, desc: "audio url"
          requires :audio_length, type: String, desc: "audio length"
          requires :question_bank_id, type: Integer, desc: "question ID"
          requires :user_id, type: Integer, desc: "user ID"
          optional :token,  type: String, desc: "token"
        end
        post do
          if current_user
            Record.create!({
              audio_url: params[:audio_url],
              audio_length: params[:audio_length],
              question_bank_id: params[:question_bank_id],
              user_id: params[:user_id]
            })
          else
            error('没有权限!', 401)
          end
        end

        desc "Get the newest three records."
        params do
          requires :question_bank_id, type: Integer, desc: "ID of question"
        end
        get  do
          QuestionBank.find(params[:question_bank_id]).records.limit(3).order('created_at DESC')
        end

        desc "find One Record"
        params do
          requires :id, type: Integer,  desc: "find one record"
        end
        get "record/:id" do
          Record.find(params[:id])
        end
      end
    end
  end
end
