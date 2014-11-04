module API
  module V1
    class QuestionLists < Grape::API
      include API::V1::Defaults

      resource :question_lists do

        desc 'tiku fetch days'
        params do
          requires :year, type: Integer, desc: 'year'
          requires :month,  type: Integer,  desc: 'month'
        end
        get :tiku_fetch_days do
          arr = []
          l = QuestionList.where(year: params[:year], month: params[:month], kind: QuestionList::KIND[:question_bank])
          if l.present?
            l.each do |d|
              arr << d.day
            end
            { stat: 1, msg: 'ok', days: arr }
          else
            { stat: 0, msg: 'no days' }
          end
        end

        desc 'on the basis of date find question/writing'
        params do
          requires :kind, type: Integer, desc: "kind: 1,question; 2,alone_writing; 3,synthetical_writing"
          requires :year, type: Integer, desc: 'year'
          requires :month, type: Integer, desc: 'month'
          requires :day,  type: Integer,  desc: 'day'
          optional :user_id,  type: Integer,  desc: 'user_id'
          optional :token,  type: String, desc: 'token'
        end
        get :date_of_qw do
          l = QuestionList.where(year: params[:year], month: params[:month], day: params[:day], kind: QuestionList::KIND[:question_bank])
          return { stat: 0, msg: '数据不存在!' } if l.blank?
          l = l.first
          if params[:kind]==1
            return { stat: 0, msg: '数据不存在!' } if l.number_ids.blank?
            q = QuestionBank.find_by(number: l.number_ids.split(',').first).answers
          elsif params[:kind]==2
            return { stat: 0, msg: '数据不存在!' } if l.alone_number_ids.blank?
            q = WritingBank.find_by(number: l.alone_number_ids.split(',').first)
          elsif params[:kind]==3
            return { stat: 0, msg: '数据不存在!' } if l.synthetical_number_ids.blank?
            q = WritingBank.find_by(number: l.synthetical_number_ids.split(',').first)
          else
            q = nil
            return { stat: 0, msg: 'kind参数不正确!' }
          end

          #参考答案
          

          if current_user && current_user.id==params[:user_id]
            
          else
  
          end
          {
            stat: 1,
            msg: 'ok',
            kind: params[:kind],
            year: l.year,
            month: l.month,
            day: l.day,
            questions: q
          }
        end

        desc "tiku_list."
        params do
          optional :year, type: Integer, default: 0, desc: "year"
        end
        get :tiku_list do
          arr = []
          params[:year] = Time.now.year if params[:year] == 0
          items = QuestionList.where(year: params[:year], kind: 1)
          items.each do |d|
            hash = {}
            hash[:id] = d[:id]
            hash[:year] = d[:year]
            hash[:month] = d[:month]
            hash[:day] = d[:day]
            hash[:kind] = d[:kind]
            hash[:question_banks] = []
            d[:number_ids].split(',').each do |m|
              q = QuestionBank.find_by(number: m)
              hash[:question_banks] << {id: q.id, number: q.number} if q.present?
            end
            arr << hash
          end
          arr
        end

        desc 'yuce recent time'
        params do

        end

        desc "yuce_list."
        params do
          optional :year, type: Integer,  default: 0, desc: "year"
          optional :month, type: Integer, default: 0, desc: "month"
          optional :day, type: Integer, default: 0, desc: "month"
        end
        get :yuce_list do
          arr = []
          params[:year] = Time.now.year if params[:year] == 0
          params[:month] = Time.now.month if params[:month] == 0
          params[:day] = Time.now.day if params[:day] == 0
          items = QuestionList.where(year: params[:year], month: params[:month], kind: 2)
          items.each do |d|
            hash = {}
            hash[:id] = d[:id]
            hash[:year] = d[:year]
            hash[:month] = d[:month]
            hash[:day] = d[:day]
            hash[:kind] = d[:kind]
            hash[:question_banks] = []
            d[:number_ids].split(',').each do |m|
              q = QuestionBank.find_by(number: m)
              hash[:question_banks] << {id: q.id, number: q.number} if q.present?
            end
            hash[:alone_writing_banks] = []
            d[:alone_number_ids].split(',').each do |m|
              w = WritingBank.find_by(number: m)
              hash[:alone_writing_banks] << {id: w.id, number: w.number} if w.present?
            end
            hash[:synthetical_number_ids] = []
            d[:synthetical_number_ids].split(',').each do |m|
              w = WritingBank.find_by(number: m)
              hash[:synthetical_number_ids] << {id: w.id, number: w.number} if w.present?
            end

            arr << hash
          end
          arr
        end
      end
    end
  end
end
