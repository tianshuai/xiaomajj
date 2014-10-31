class WriteRecords < ActiveRecord::Base
  belongs_to :user
  belongs_to :writing_bank
end
