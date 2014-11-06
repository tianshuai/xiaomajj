class WritingBank < ActiveRecord::Base

  has_many :comments, dependent: :destroy,  as: :relateable


  validates :title,                                length: { maximum: 50, message: '小于50个字符' }
  validates :content,                                length: { minimum: 2, maximum: 2000, message: '长度大于2个字符且小于2000个字符' }
end
