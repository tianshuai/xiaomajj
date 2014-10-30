module API
  module V1
    class QuestionLists < Grape::API
      include API::V1::Defaults

      resource :question_lists do

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
            arr << hash
          end
          arr
        end
      end
    end
  end
end
