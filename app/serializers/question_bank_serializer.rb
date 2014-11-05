class QuestionBankSerializer < ActiveModel::Serializer
  attributes :id, :number, :title, :content, :tags, :video_url
  has_many :answers
  #has_many :records

  def answers
  	object.answers.limit(3).order('created_at DESC')
  end

  def records
  	#object.records.limit(3).order('created_at DESC')
  end

  def comments
  	#object.comments.order('created_at DESC').limit(10)
  end
end
