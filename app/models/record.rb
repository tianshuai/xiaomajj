class Record < ActiveRecord::Base
  mount_uploader :audio_url, AudioUploader
  belongs_to :user
  belongs_to :question_bank
end
