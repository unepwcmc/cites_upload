set :rails_env, "production"

# Primary domain name of your application. Used in the Apache configs
set :domain, "unepwcmc-014.vm.brightbox.net"

## List of servers
server "unepwcmc-014.vm.brightbox.net", :app, :web, :db, :primary => true

set :default_environment, {
'PATH' => "/home/rails/.rvm/gems/ruby-1.9.2-p320/bin:/home/rails/.rvm/bin:/home/rails/.rvm/rubies/ruby-1.9.2-p320/bin:$PATH",
'RUBY_VERSION' => 'ruby-1.9.2-p320',
'GEM_HOME' => '/home/rails/.rvm/gems/ruby-1.9.2-p320',
'GEM_PATH' => '/home/rails/.rvm/gems/ruby-1.9.2-p320',
}

