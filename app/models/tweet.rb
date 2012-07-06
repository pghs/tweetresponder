class Tweet < ActiveRecord::Base
	belongs_to :user
	belongs_to :question

	def self.unanswered
		where(:answered => false)
	end

	def self.answered
		where(:answered => true)
	end

	def self.get_dms
		return Twitter.direct_messages()
	end

	def self.cron
		puts 'cronned'
	end

	def self.post_status(msg)
		if msg.length<141
			return Twitter.update(msg)
		else
			false
		end
	end

	def self.check_mentions()
		tweets = Twitter.mentions({:count => 200})
		tweets.each do |t|
			Tweet.save_tweet_data(t)
		end
		return true
	end

	def self.save_tweet_data(t)
		u = User.find_or_create_by_t_id(t.user.id)
		u.update_attributes(:t_name => t.user.name, :t_screen_name => t.user.screen_name)
		puts "#{u.id}: #{u.t_screen_name}"
		tw = Tweet.find_or_create_by_t_id(t.id)
		unless tw.message == t.text and 
			tw.in_reply_to_user_id == t.to_user_id and
			tw.in_reply_to_status_id = t.in_reply_to_status_id and
			tw.user_id = u.id
				tw.update_attributes(:message => t.text,
					:in_reply_to_user_id => t.in_reply_to_user_id,
					:in_reply_to_status_id => t.in_reply_to_status_id,
					:user_id => u.id)
		end

		msg = tw.message
		hashtag = msg =~ /#/
		if hashtag
			sp = msg.index(/ /,hashtag)
			sp = -1 if sp.nil?
			question_id = msg.slice(hashtag..sp).to_i
			question_id = nil if question_id==0
			tw.update_attributes(:question_id => question_id)
		end
	end
end
