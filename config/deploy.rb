require 'capistrano/ext/multistage' # for multi stage

set :repository,  "git@97.107.140.182:popravi.git"
set :user, "dalybr"
set :scm, :git
set :stages, %w(staging production)
set :default_stage, "staging"
set :use_sudo, false
# set :keep_releases, 1

# If you’re not seeing commands prompt like they used to, like svn or passwd,
# you can return to the previous behavior by adding the following line to your capfile:
default_run_options[:pty] = true

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/public/assets #{release_path}/public/assets"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'
