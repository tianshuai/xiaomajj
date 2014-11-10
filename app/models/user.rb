class User < ActiveRecord::Base

  has_many :comments

  #验证邮箱格式
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #验证手机号码
  VALID_PHONE_REGEX = /\A1\d{10}\z/

  ##验证
  validates_presence_of :login,                    message: '不能为空'
  validates_uniqueness_of :login,                   message: '用户名已存在'
  validates :login,                                length: { minimum: 2, maximum: 30, message: '长度大于2个字符且小于30个字符' }

  #validates_presence_of :email,                   message: '不能为空'
  #validates :email,                               format: { with: VALID_EMAIL_REGEX,  message: '格式不正确' }
  #validates :phone,                               format: { with: VALID_PHONE_REGEX,  message: '格式不正确' }

  def authenticate(password)
  	self.password == password
  end

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  #加密token
  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  #判断邮箱是否存在
  def self.have_email?(email)
    return true if self.find_by(email: email)
    return false
  end

  #判断手机号是否存在
  def self.have_phone?(phone)
    return true if self.find_by(phone: phone)
    return false
  end

  #判断昵称是否存在
  def self.have_login?(login)
    return true if self.find_by(login: login.strip)
    return false
  end

end
