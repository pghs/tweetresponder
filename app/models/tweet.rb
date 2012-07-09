class Tweet < ActiveRecord::Base
	belongs_to :user
	belongs_to :question

	def self.unanswered
		where(:answered => false)
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
			tw.in_reply_to_user_id == t.in_reply_to_user_id and
			tw.in_reply_to_status_id == t.in_reply_to_status_id and
			tw.user_id == u.id
				tw.update_attributes(:message => t.text,
					:in_reply_to_user_id => t.in_reply_to_user_id,
					:in_reply_to_status_id => t.in_reply_to_status_id,
					:user_id => u.id)
		end

		if tw.in_reply_to_status_id
			q = Question.find_by_tweet_id(tw.in_reply_to_status_id)
			tw.update_attributes(:question_id => q.id) if q
		elsif tw.message =~ /bit.ly/
			msg = tw.message
			link_pos = msg =~ /bit.ly/
			sp = msg.index(/ /,link_pos)
			sp = -1 if sp.nil?
			bitly_link = msg.slice(link_pos..sp)
			q = nil
			q = Question.find_by_short_url("http://#{bitly_link}") unless bitly_link.nil?
			tw.update_attributes(:question_id => q.id) if q
		else
			msg = tw.message
			hashtag = msg =~ /#/
			if hashtag
				sp = msg.index(/ /,hashtag)
				sp = -1 if sp.nil?
				question_id = msg.slice(hashtag+1..sp).to_i
				question_id = nil if question_id==0
				q = nil
				q = Question.find_by_q_id(question_id) unless question_id.nil?
				tw.update_attributes(:question_id => q.id) if q
			end
		end
	end
end
