require 'bundler/capistrano'
require 'puma/capistrano'

set :application, "askacountry"
set :repository,  "git@github.com:jeremyby/rating.git"
set :branch, "master"
set :deploy_to, "/var/www/askacountry"
set :keep_releases, 3

set :scm, :git
set :user, "deployer"
set :use_sudo, false
set :deploy_via, :remote_cache

default_run_options[:pty] = true
default_run_options[:shell] = '/bin/bash -l'


server "edinburgh", :app, :web, :db, :primary => true

# role :web, "ec2-54-241-119-74.us-west-1.compute.amazonaws.com"                          # Your HTTP server, Apache/etc
# role :app, "ec2-54-241-119-74.us-west-1.compute.amazonaws.com"                          # This may be the same as your `Web` server
# role :db,  "ec2-54-241-119-74.us-west-1.compute.amazonaws.com", :primary => true       # This is where Rails migrations will run
# role :db,  "your slave db-server here"



# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"