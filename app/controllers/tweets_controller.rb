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
				#code for responding to correct tweet goes here
			when 0
				puts 'wrong!'
				#code for responding to incorrect tweet goes here
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
