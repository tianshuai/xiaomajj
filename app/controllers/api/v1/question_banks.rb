module API
  module V1
    class QuestionBanks < Grape::API
      include API::V1::Defaults

      resource :question_banks do
        desc "Return a question_bank for ID"
        params do
          requires :id, type: Integer, desc: "ID of the question_bank"
        end
        get ":id" do
          begin
            QuestionBank.find(params[:id])
          rescue=>e
            error!('not found!', 401)
          end
        end

        desc "Return a question_bank for Number"
        params do
          requires :number, type: String, desc: "Number of the question_bank"
        end
        get "number/:number" do
          QuestionBank.find_by(number: params[:number])
        end
      end
    end
  end
end
