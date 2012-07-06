class TweetsController < ApplicationController
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
				puts 'right!'
				#Tweet.post_status("@#{tweet.user.t_screen_name} Correct! #questionhashtag")
			when 0
				puts 'wrong!'
				#Tweet.post_status(
				#	"@#{tweet.user.t_screen_name} Sorry, that's not what were looking for. Check out #LINK and click 'teach me' to learn more! #questionhashtag"
				#)
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
