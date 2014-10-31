class UserMailer < ActionMailer::Base
  default from: "xiaoma_pwd@163.com"

  def find_pwd(user, mark)
	  @user = user
	  @url = "#{File.join(CONF['static_domain'], 'user/reset_pwd')}?mark=#{mark}"
    mail(to: user.email, subject: "小马机经-找回密码")
  end

end
