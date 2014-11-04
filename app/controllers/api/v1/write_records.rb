module API
  module V1
    class WriteRecords < Grape::API
      include API::V1::Defaults

      resource :write_records do
        desc "Return a write_record for ID"
        params do
          requires :id, type: Integer, desc: "ID of the write_record"
        end
        get do
          begin
            write = WriteRecord.find(params[:id])
            { stat: 1, msg: '', write_record: write }
          rescue=>e
            { stat: 0, msg: '没有找到' }
          end
        end

        desc "Create a write_record."
        params do
          requires :content, type: String, desc: "content"
          requires :writing_bank_id, type: Integer, desc: "writing_bank ID"
          requires :user_id, type: Integer, desc: "user ID"
          #optional :title, type: String, desc: 'title'
          optional :is_amend, type: Integer,  default: 0, desc: 'allow teacher amend?'
          optional :kind, type: Integer,  default: 1, desc: '综合 ？独立'
          optional :token,  type: String, desc: "token"
        end
        post do
          if current_user
            record = WriteRecord.new({
              content: params[:content],
              writing_bank_id: params[:writing_bank_id],
              user_id: params[:user_id],
              is_amend: params[:is_amend],
              kind: params[:kind]
            })
            if record.save
              { stat: 1, msg: '创建成功!' }
            else
              { stat: 0, msg: record.errors }
            end
          else
            { stat: 0, msg: '没有权限!' }
          end
        end

      end
    end
  end
end
