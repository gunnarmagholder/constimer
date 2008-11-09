set :application, "www.road-timer.com"
set :user, "deploy"
set :repository,  "git@github.com:gunnarmagholder/constimer.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/apps/#{application}"

set :scm, :git 
set :domain, "v30136.1blu.de"
role :app, domain
role :web, domain
role :db,  domain, :primary => true

set :runner, user

set :mongrel_servers, 3
set :mongrel_port, 8000
set :rails_env, 'production'
