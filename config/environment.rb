# Load the Rails application.
require File.expand_path('../application', __FILE__)

#自定义常量
CONF = YAML.load_file("#{Rails.root}/config/site_config.yml")[Rails.env]

# Initialize the Rails application.
Rails.application.initialize!
