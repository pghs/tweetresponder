#lib/tasks/cron.rake
task :check_mentions => :environment do
  Tweet.check_mentions
end

task :tweet => :environment do
  t = Time.now
	if t.hour > 7 and t.hour < 21
		Tweet.send_next_tweet
		Tweet.set_next
	end
end