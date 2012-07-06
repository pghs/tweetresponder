class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :t_id
      t.integer :user_id
      t.integer :question_id
      t.text :message
      t.integer :in_reply_to_status_id
      t.integer :in_reply_to_user_id
      t.boolean :answered, :default => false

      t.timestamps
    end
  end
end
