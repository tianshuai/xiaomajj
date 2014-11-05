module API
  module V1
    class Comments < Grape::API
      include API::V1::Defaults

      resource :comments do
        desc "Create a comment."
        params do
          requires :content, type: String, desc: "content"
          requires :relateable_id, type: Integer, desc: "id"
          requires :kind, type: Integer, desc: "1.QuestionBank ; 2.WritingBank"
          requires :user_id, type: Integer, desc: "user ID"
          optional :token,  type: String, desc: "token"
        end
        post do
          if params[:kind]==1
            relateable_type = 'QuestionBank'
          elsif params[:kind]==2
            relateable_type = 'WritingBank'
          else
            return { stat: 0, msg: '传入类型错误!' }
          end
          if current_user && current_user.id==params[:user_id]
            comment = Comment.new({
              content: params[:content],
              relateable_id: params[:relateable_id],
              relateable_type: relateable_type,
              user_id: params[:user_id]
            })
            if comment.save
              { stat: 1, msg: 'ok', comment: comment }
            else
              { stat: 0, msg: comment.errors }
            end
          else
            { stat: 0, msg: '没有权限' }
          end
        end

        desc "Get the comments."
        params do
          requires :relateable_id, type: Integer, desc: "ID of question Bank or writing bank"
          requires :kind, type: Integer, desc: "1.QuestionBank; 2.WritingBank"
        end
        get :list do
          if params[:kind]==1
            relateable_type = 'QuestionBank'
          elsif params[:kind]==2
            relateable_type = 'WritingBank'
          else
            return { stat: 0, msg: '传入类型错误!' }
          end
          Comment.where(relateable_id: params[:relateable_id], relateable_type: relateable_type).order('created_at DESC').limit(20)
        end
      end
    end
  end
end
