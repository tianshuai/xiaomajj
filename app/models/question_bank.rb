class QuestionBank < ActiveRecord::Base
	#mount_uploader :video_url, AudioUploader
	has_many :answers
	has_many :records
	has_many :opinions
end
