class WritingBank < ActiveRecord::Base



  validates :title,                                length: { maximum: 50, message: '小于50个字符' }
  validates :content,                                length: { minimum: 2, maximum: 500, message: '长度大于2个字符且小于500个字符' }
end
