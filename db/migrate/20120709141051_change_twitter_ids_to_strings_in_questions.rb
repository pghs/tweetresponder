class ChangeTwitterIdsToStringsInQuestions < ActiveRecord::Migration
  def change
  	#remove_column :tweets, :t_id, :integer
  	#remove_column :questions, :tweet_id, :integer
    add_column :tweets, :t_id, :string
    add_column :questions, :tweet_id, :string
  end
end
