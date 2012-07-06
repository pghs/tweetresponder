#lib/tasks/cron.rake
task :check_mentions => :environment do
  Tweet.check_mentions
end

task :tester => :environment do
	Tweet.cron
end