module API
  module V1
    class Home < Grape::API
      include API::V1::Defaults

      namespace :home do
        desc "index yuce/tiku"
        params do
          optional :evt,  type: Integer, default: 1, desc: '1.yuce;2.tiku'
        end
        get :yuce do
          if params[:evt]==1
            mark = 'index_yuce'
          else
            mark = 'index_tiku'
          end
          block = Block.find_by(mark: mark)
          if block.present?
            arr = []
            tag = block.content
            return { stat: 0, msg: '内容不存在!' } if tag.blank?
            tag.split('##').each do |m|
              m = m.split('@@')
              break if m.size !=2
              m[0].split(';;').each do |n|
                s = n.split('::')
                break if s.size != 2
                if m[1].to_i==1
                  q = QuestionBank.find_by(number: s[1])
                else
                  q = WritingBank.find_by(number: s[1])
                end
                break unless q
                arr << { date: s[0], kind: m[1], content: q }

              end
            end
            { stat: 1, msg: 'ok', data: arr }
          else
            { stat: 0, msg: '内容不存在!' }
          end
        end

      end
    end
  end
end
