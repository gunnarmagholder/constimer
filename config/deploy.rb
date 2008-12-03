set :application, "www.road-timer.com"
set :user, "deploy"


# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/#{user}/apps/#{application}"
# set :deploy_via, :remote_cache
set :scm, :git 
set :repository,  "git@github.com:gunnarmagholder/constimer.git"
# set :branch, "master"

# default_run_options[:pty] = true
# ssh_options[:forward_agent] = true
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
