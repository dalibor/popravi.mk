desc "Install gems and do db:setup"
task :clean => ["log:clear", "capy:clean"]