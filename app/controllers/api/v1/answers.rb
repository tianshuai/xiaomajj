module API
  module V1
    class Answers < Grape::API
      include API::V1::Defaults

      resource :answers do
        desc "Return a question_bank for ID"
        params do
          requires :question_bank_id, type: Integer, desc: "ID of the question_bank"
        end
        get :list do
          Answer.where(question_bank_id: params[:question_bank_id]).limit(3).order('created_at DESC')
        end

      end
    end
  end
end
