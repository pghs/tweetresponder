#lib/tasks/cron.rake
task :check_mentions => :environment do
  Tweet.check_mentions
end

task :tweet => :environment do
	puts "TWEET RUN"
	Tweet.send_next_tweet
	Tweet.set_next
end