set :application, "www.road-timer.com"
set :user, "deploy"

set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :scm, :git 
set :repository,  "git@github.com:gunnarmagholder/constimer.git"

set :use_sudo, false 
set :scm_verbose, true


set :domain, "h1439698.stratoserver.net"
role :app, domain
role :web, domain
role :db,  domain, :primary => true

set :runner, user

set :mongrel_servers, 3
set :mongrel_port, 8000
set :rails_env, 'production'

namespace :deploy do
  desc "Anwendung neu starten"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end