#lib/tasks/cron.rake
task :check_mentions => :environment do
  Tweet.check_mentions
end

task :tweet => :environment do
	puts "TWEET RUN"
	Question.send_next_tweet
	Question.set_next
end