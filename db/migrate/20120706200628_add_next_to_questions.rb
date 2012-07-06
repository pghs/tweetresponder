class AddNextToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :next, :integer
    add_column :questions, :tweet_id, :integer
  end
end
