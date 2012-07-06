class Question < ActiveRecord::Base
	has_many :tweets

	def self.next
		where(:next => 1).first
	end

	def self.bio
		bio_lesson_ids = [111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 145, 146, 147, 149, 150, 155, 163, 164, 165, 166, 167, 168, 170, 174, 180, 184, 185, 187, 192, 189, 190, 193, 188, 195, 196, 191, 194, 197, 204, 224, 225, 226]
		where(:lesson_id => bio_lesson_ids)
	end

	def self.send_next_tweet
		q = Question.bio.next
		puts q.inspect
		if q
			authorize = UrlShortener::Authorize.new 'o_29ddlvmooi', 'R_4ec3c67bda1c95912185bc701667d197'
	    client = UrlShortener::Client.new authorize
			short_url = client.shorten(q.url).urls
			tweet = q.tweet
			q.update_attributes(:tweet => "#{tweet} #{short_url}", :short_url => short_url, :next => nil)
			t = Tweet.post_status(q.tweet)
			q.update_attributes(:tweet_id => t.id)
		end
	end

	def self.set_next
		q = Question.bio.sample
		puts q.inspect
		if q.tweet
			q.update_attributes(:next => 1)
		else
			Tweet.set_next
		end
	end
end
