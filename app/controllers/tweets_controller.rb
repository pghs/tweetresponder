class TweetsController < ApplicationController
	AFFIRMATIVE = [
		"Correct!",
		"Right!",
		"Yes!",
		"That's it!",
		"You got it!"
	]

	COMPLEMENT = [
		"",
		"Nice job",
		"Nicely done",
		"Awesome",
		"Way to go"
	]


	def index
		@tweets = Tweet.unanswered
	end

	def check
		Tweet.check_mentions
		render :nothing => true
	end

	def respond_to_tweet
		tweet = Tweet.find_by_id(params[:tweet_id])
		if tweet
			puts params[:correct]
			case params[:correct].to_i
			when 1
				puts "@#{tweet.user.t_screen_name} #{AFFIRMATIVE.sample} #{COMPLEMENT.sample} ##{tweet.question.q_id}"
				Tweet.post_status("@#{tweet.user.t_screen_name} #{AFFIRMATIVE.sample} #{COMPLEMENT.sample} ##{tweet.question.q_id}")
			when 0
				puts "@#{tweet.user.t_screen_name} Sorry, that's not what were looking for. Check out #{tweet.question.short_url} and click 'teach me' to learn more! ##{tweet.question.q_id}"
				Tweet.post_status(
					"@#{tweet.user.t_screen_name} Sorry, that's not what were looking for. Check out #{tweet.question.short_url} and click 'teach me' to learn more! ##{tweet.question.q_id}"
				)
			else
				puts 'skip'
			end
			tweet.update_attributes(:answered => true)
			render :nothing => true, :status => 200
		else
			render :nothing => true, :status => 300
		end
	end
end
