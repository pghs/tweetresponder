Tweetchecker::Application.routes.draw do

  get "users/index"

  resources :questions

	match '/tweet/check' => 'tweets#check'
	match '/tweet/respond_to_tweet' => 'tweets#respond_to_tweet', :via => :post

	match '/import_qb' => 'questions#import_from_qb'
	match '/create_tweets' => 'questions#create_tweets'

  root :to => 'tweets#index'
end
