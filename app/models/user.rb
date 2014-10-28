class User < ActiveRecord::Base

  #验证邮箱格式
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  ##验证
  validates_presence_of :login,                    message: '不能为空'
  #validates_uniqueness_of :login,				　message: '用户名已存在'
  validates :login,                                length: { minimum: 2, maximum: 30, message: '长度大于2个字符且小于30个字符' }

  validates_presence_of :email,                   message: '不能为空'
  validates :email,                               format: { with: VALID_EMAIL_REGEX,  message: '格式不正确' },
                                                  uniqueness: { case_sensitive: false, message: '已经存在!' }

  def authenticate(password)
  	self.password == password
  end
end
