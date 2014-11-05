class QuestionBank < ActiveRecord::Base
	#mount_uploader :video_url, AudioUploader
  
  has_many :comments, dependent: :destroy,  as: :relateable
	has_many :answers
	has_many :records
end
