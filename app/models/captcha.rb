class Captcha < ActiveRecord::Base

  #常量
  KIND = {
    #邮箱验证
    email: 1,
    #手机验证
    phone: 2
  }

  #限制发送短信/email间隔
  def is_expire_message?
    return true if (self.expires_at + 60) < Time.now.to_i
    return false
  end

  #是否过期
  def is_expire?
    if self.kind==1
      n = 3600
    elsif self.kind==2
      n = 300
    else
      n = 300
    end
    return true if (self.expires_at + n) < Time.now.to_i
    return false
  end

  #生成手机验证码(6位随机数字)
  def self.generate_phone_code
    rand(100000..999999)
  end

end
