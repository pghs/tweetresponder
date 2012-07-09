class ChangeTweetUserIdBackToStr < ActiveRecord::Migration
  def change
  	remove_column :tweets, :t_id
    add_column :tweets, :t_id, :integer
  end
end
