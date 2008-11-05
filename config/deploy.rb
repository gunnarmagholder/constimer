set :application, "www.road-timer.com"
set :user, "deploy"
set :repository,  "git@github.com:gunnarmagholder/constimer.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

set :scm, :git 

role :app, "v30136.1blu.de"
role :web, app
role :db,  app, :primary => true

# Startup for mongrel, FCGI etc
set :runner, user 

set :mongrel_servers, 2
set :mongrel_port, 8000
set :rails_env, "production"

