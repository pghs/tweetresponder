class AddAnsweredToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :answered, :boolean, :default => false
  end
end
