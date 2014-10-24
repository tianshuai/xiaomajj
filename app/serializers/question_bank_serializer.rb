class QuestionBankSerializer < ActiveModel::Serializer
  attributes :id, :number, :title, :content, :tags, :video_url
  has_many :answers
  has_many :records
  has_many :opinions

  def answers
  	object.answers.limit(3).order('created_at DESC')
  end

  def records
  	object.records.limit(3).order('created_at DESC')
  end

  def opinions
  	object.opinions.order('created_at DESC').limit(10)
  end
end
