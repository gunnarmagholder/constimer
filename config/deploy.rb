set :application, "www.road-timer.com"
set :user, "deploy"
set :repository,  "git@github.com:gunnarmagholder/constimer.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/#{application}"

set :scm, :git 
set :domain, "v30136.1blu.de"
role :app, domain
role :web, domain
role :db,  domain, :primary => true


default_run_options[:pty] = true
set :user, "deploy"
set :ssh_options, { :forward_agent => true }
set :use_sudo, false

namespace :deploy do
  desc "upload database configuration"
  task :upload_database_configuration, :roles => :app do
    run "mkdir -p #{shared_path}/config"
    config = File.read(File.join(File.dirname(__FILE__), "database.yml"))
    put config, "#{shared_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  end
  
  after "deploy:finalize_update", "deploy:upload_database_configuration"
end