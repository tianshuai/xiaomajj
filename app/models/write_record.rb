class WriteRecord < ActiveRecord::Base
  belongs_to :user
  belongs_to :writing_bank

  validates :content,                                length: { minimum: 2, maximum: 500, message: '长度大于2个字符且小于500个字符' }
end