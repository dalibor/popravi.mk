# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever


# http://blog.scoutapp.com/articles/2010/09/07/rvm-and-cron-in-production
# fix for rvm system wide install on server (for correct env vars etc.)
set :job_template, "bash -l -i -c ':job'"

set :output, "#{path}/log/cron.log"

# production environment, set crontab with:
# whenevere -i
every :sunday, :at => '02am' do
  runner "Problem.send_problems!"
end

# development environment for testing, set crontab with:
# whenever -i --set environment=development
#every 1.minute do
  #runner "Problem.send_problems!"
#end
