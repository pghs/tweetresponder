class ChangeTweetIdsToBigint < ActiveRecord::Migration
  def change
  	remove_column :tweets, :t_id
  	remove_column :tweets, :in_reply_to_status_id
  	remove_column :tweets, :in_reply_to_user_id
  	remove_column :questions, :tweet_id
    add_column :tweets, :in_reply_to_status_id, :bigint
    add_column :tweets, :in_reply_to_user_id, :bigint
    add_column :tweets, :t_id, :bigint
    add_column :questions, :tweet_id, :bigint
  end
end
