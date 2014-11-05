class Comment < ActiveRecord::Base

  #关联
  belongs_to :relateable,   polymorphic: true
  belongs_to :user

  #验证
  validates :content,                                length: { minimum: 2, maximum: 500, message: '长度大于2个字符且小于500个字符' }

end
