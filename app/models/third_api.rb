class ThirdApi < ActiveRecord::Base

  #关系
  belongs_to :user

  #常量
  KIND = {
    #微博
    wb: 1,
    #QQ
    qq: 2
  }

end
