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
          optional :token,  type: String, desc: "token"
        end
        post do
          if current_user
            Opinion.create!({
              content: params[:content],
              question_bank_id: params[:question_bank_id],
              user_id: params[:user_id]
            })
          else
            error!('没有权限!', 401)
          end
        end

        desc "Get the opinions."
        params do
          requires :question_bank_id, type: Integer, desc: "ID of question Bank"
        end
        get :list do
          QuestionBank.find(params[:question_bank_id]).opinions.order('created_at DESC').limit(10)
        end
      end
    end
  end
end
