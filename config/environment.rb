ActiveEnv = 'development'

ENV['RAILS_ENV'] ||= ActiveEnv

RAILS_GEM_VERSION = '2.1.2' unless defined? RAILS_GEM_VERSION
HOST = case ActiveEnv
  when 'development' then 'http://127.0.0.1:3000'
  when 'test'        then 'http://127.0.0.1'
  when 'production'  then 'http://www.constimer.com'
end 

require File.join(File.dirname(__FILE__), 'boot')
Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
  config.action_controller.session = {
    :session_key => '_constime_session',
    :secret      => 'ac2cb86285a5659d56c766bfa3be115b5a993ae4b22fd084ffd9d8dc96f84e12b9602df36dbf6ba9569344c218f613d9d5d9ff99db7d9ff88283db71159808f3'
  }
  config.active_record.observers = :user_observer
end

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings= {
  :address => "smtp.web.de",
  :port => '25',
  :domain => 'web.de',
  :username => 'gmagholder@web.de',
  :password => 'X25a5250!',
  :authentication => :login
}
