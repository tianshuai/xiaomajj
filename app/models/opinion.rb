class Opinion < ActiveRecord::Base
  belongs_to :user

  validates :content,                                length: { minimum: 2, maximum: 140, message: '长度大于2个字符且小于140个字符' }

end
