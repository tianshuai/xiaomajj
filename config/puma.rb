#ls_env = ENV['RAILS_ENV'] || 'development'

threads 4,4
environment 'production'
bind  "unix:///home/xiaomajijing/xiaomajj3/shared/tmp/sockets/puma.sock"
pidfile "/home/xiaomajijing/xiaomajj3/current/tmp/pids/puma.pid"
state_path "/home/xiaomajijing/xiaomajj3/current/tmp/pids/puma.state"

activate_control_app
