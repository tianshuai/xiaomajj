module API
  module V1
    class WritingBanks < Grape::API
      include API::V1::Defaults

      resource :writing_banks do
        desc "Return a writing_bank for ID"
        params do
          requires :id, type: Integer, desc: "ID of the writing_bank"
        end
        get do
          begin
            write = WritingBank.find(params[:id])
            { stat: 1, msg: 'success', writing_bank: write }
          rescue=>e
            { stat: 0, msg: '不存在!' }
          end
        end

        desc "Return a writing_bank for Number"
        params do
          requires :number, type: String, desc: "Number of the writing_bank"
        end
        get "number/:number" do
          write = WritingBank.find_by(number: params[:number])
          if write.present?
            { stat: 1, msg: 'success', writing_bank: write }
          else
            { stat: 0, msg: '不存在!' }
          end
        end
      end
    end
  end
end
