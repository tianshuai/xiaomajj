class QuestionList < ActiveRecord::Base

  #常量
  KIND = {
    #题库
    question_bank: 1,
    #预测
    calculate: 2
  }
end
