set :default_stage, 'staging'
require 'capistrano/ext/multistage'

## Generated with 'brightbox' on Thu Apr 21 11:12:49 +0100 2011
gem 'brightbox', '>=2.3.8'
require 'brightbox/recipes'
require 'brightbox/passenger'

load 'deploy/assets'
# The name of your application.  Used for deployment directory and filenames
# and Apache configs. Should be unique on the Brightbox
set :application, "cites-upload"
set :rake, "bundle exec rake"


# Target directory for the application on the web and app servers.
set(:deploy_to) { File.join("", "home", user, application) }

# URL of your source repository. By default this will just upload
# the local directory.  You should probably change this if you use
# another repository, like git or subversion.

#set :deploy_via, :copy
set :repository, "git@github.com:unepwcmc/cites_upload.git"

set :scm, :git
set :branch, "master"
set :scm_username, "unepwcmc-read"
set :git_enable_submodules, 1
default_run_options[:pty] = true # Must be set for the password prompt from git to work

## Dependencies
# Set the commands and gems that your application requires. e.g.
# depend :remote, :gem, "will_paginate", ">=2.2.2"
# depend :remote, :command, "brightbox"
#
# Specify your specific Rails version if it is not vendored
#depend :remote, :gem, "rails", "=2.3.8"
#depend :remote, :gem, "authlogic", "=2.1.4"
#depend :remote, :gem, "faker", "=0.9.5"
#depend :remote, :gem, "hashie", "=0.2.0"
#depend :remote, :gem, "pg", "=0.11.0"

## Local Shared Area
# These are the list of files and directories that you want
# to share between the releases of your application on a particular
# server. It uses the same shared area as the log files.
#
# So if you have an 'upload' directory in public, add 'public/upload'
# to the :local_shared_dirs array.
# If you want to share the database.yml add 'config/database.yml'
# to the :local_shared_files array.
#
# The shared area is prepared with 'deploy:setup' and all the shared
# items are symlinked in when the code is updated.
set :local_shared_files, %w(config/database.yml)
set :local_shared_dirs, %w(public/system)

task :setup_production_database_configuration do
  the_host = Capistrano::CLI.ui.ask("Database IP address: ")
  database_name = Capistrano::CLI.ui.ask("Database name: ")
  database_user = Capistrano::CLI.ui.ask("Database username: ")
  pg_password = Capistrano::CLI.password_prompt("Database user password: ")
  require 'yaml'
  spec = { rails_env => {
    "adapter" => "postgresql",
    "database" => database_name,
    "username" => database_user,
    "host" => the_host,
    "password" => pg_password }}
    run "mkdir -p #{shared_path}/config"
    put(spec.to_yaml, "#{shared_path}/config/database.yml")
end
after "deploy:setup", :setup_production_database_configuration


# TODO: got rid of s3_storage.yml and setup_mail.rb - those values should go into .env file
# SECRET_KEY_BASE
# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY
# MAILER_ADDRESS_KEY
# MAILER_PORT_KEY
# MAILER_DOMAIN_KEY
# MAILER_USERNAME_KEY
# MAILER_PASSWORD_KEY
# MAILER_ASSET_HOST_KEY
# MAILER_HOST_KEY

# got sick of "gem X not found in any of the sources" when using the default whenever recipe
# probable source of issue:
# https://github.com/javan/whenever/commit/7ae1009c31deb03c5db4a68f5fc99ea099ce5655
namespace :deploy do

  task :default do
    update
    assets.precompile
    restart
    cleanup
    # etc
  end

  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

end
 
namespace :assets do
  desc "Precompile assets locally and then rsync to app servers"
    task :precompile, :only => { :primary => true } do
    run_locally "bundle exec rake RAILS_ENV=staging assets:precompile;"
    servers = find_servers :roles => [:app], :except => { :no_release => true }
    servers.each do |server|
    run_locally "rsync -av ./public/assets/ rails@#{domain}:#{deploy_to}/shared/assets;"
    end
    run_locally "rm -rf public/assets"
    run "ln -nfs #{deploy_to}/shared/assets #{deploy_to}/current/public/assets"
  end
end
