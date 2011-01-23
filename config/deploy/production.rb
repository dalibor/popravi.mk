set :application, "popravi.mk"
set :deploy_to, "/home/#{user}/www/#{application}"
set :rails_env, "production"
set :domain, "#{user}@#{application}"

role :web, domain
role :app, domain
# or: server domain, :app, :web
role :db,  domain, :primary => true # This is where Rails migrations will run

#set :branch, "stable"
