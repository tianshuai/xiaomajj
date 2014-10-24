class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :month, :number, :title, :content, :video_url
  has_many :answers
  has_many :records
  has_many :opinions

  def answers
  	object.answers.limit(3)
  end

  def records
  	object.records.limit(3)
  end

  def opinions
  	object.opinions.limit(8)
  end
end
