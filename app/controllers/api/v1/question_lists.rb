module API
  module V1
    class QuestionLists < Grape::API
      include API::V1::Defaults

      resource :question_lists do

        desc "tiku_list."
        params do
          requires :year, type: Integer, desc: "year"
        end
        get :tiku_list do
          arr = []
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
          requires :year, type: Integer, desc: "year"
          requires :month, type: Integer, desc: "month"
        end
        get :yuce_list do
          arr = []
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
