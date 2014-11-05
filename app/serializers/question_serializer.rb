class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :month, :number, :title, :content, :video_url
  has_many :answers
  has_many :records

  def answers
  	object.answers.limit(3)
  end

  def records
  	object.records.limit(3)
  end

  def comments
  	object.comments.limit(8)
  end
end
