class AddStringIdsToTweets < ActiveRecord::Migration
  def change
  	remove_column :tweets, :in_reply_to_status_id
  	remove_column :tweets, :in_reply_to_user_id
    add_column :tweets, :in_reply_to_status_id, :string
    add_column :tweets, :in_reply_to_user_id, :string
  end
end
