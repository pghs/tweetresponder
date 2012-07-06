class AddQuestionIdToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :question_id, :integer
    remove_column :tweets, :reply_id
  end
end
