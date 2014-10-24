class Practise < ActiveRecord::Base
  mount_uploader :audio_url, VideoUploader
  belongs_to :user
  belongs_to :question_bank
end
