set :application, "staging.popravi.mk"
set :deploy_to, "/home/#{user}/www/#{application}"
set :rails_env, "development"
set :domain, "#{user}@#{application}"

role :web, domain
role :app, domain
# or: server domain, :app, :web
role :db,  domain, :primary => true # This is where Rails migrations will run

#set :branch, "master"
