module API
  module V1
    class Opinions < Grape::API
      include API::V1::Defaults

      resource :Opinions do

        desc "Create a Opinions."
        params do
          requires :content, type: String, desc: "opinion content"
          requires :question_bank_id, type: Integer, desc: "question Bank ID"
          requires :user_id, type: Integer, desc: "user ID"
        end
        post do
          Opinion.create!({
            content: params[:content],
            question_bank_id: params[:question_bank_id],
            user_id: params[:user_id]
          })
        end

        desc "Get the newest three opinions."
        params do
          requires :question_bank_id, type: Integer, desc: "ID of question Bank"
        end
        get do
          QuestionBank.find(params[:question_bank_id]).opinions.order('created_at DESC').limit(10)
        end
      end
    end
  end
end
