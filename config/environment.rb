require 'yaml'
ActiveEnv = 'development'
require File.join(File.dirname(__FILE__), 'boot')
ENV['RAILS_ENV'] ||= ActiveEnv
raw_config = File.read(RAILS_ROOT + "/config/config.yml")
APP_CONFIG = YAML.load(raw_config)[RAILS_ENV]


RAILS_GEM_VERSION = '2.2.2' unless defined? RAILS_GEM_VERSION
HOST = case ActiveEnv
  when 'development' then '127.0.0.1:3000'
  when 'test'        then '127.0.0.1'
  when 'production'  then 'www.road-timer.com'
end 

require File.join(File.dirname(__FILE__), 'boot')
Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
  config.action_controller.session = {
    :session_key => '_constime_session',
    :secret      => 'ac2cb86285a5659d56c766bfa3be115b5a993ae4b22fd084ffd9d8dc96f84e12b9602df36dbf6ba9569344c218f613d9d5d9ff99db7d9ff88283db71159808f3'
  }
  config.active_record.observers = :user_observer
  # config.gem 'jscruggs-metric_fu', :version => '0.9.0', :lib => 'metric_fu', :source => 'http://gems.github.com'
end

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings= {
  :address => "127.0.0.1",
  :port => '25',
  :domain => 'road-timer.com',
}
