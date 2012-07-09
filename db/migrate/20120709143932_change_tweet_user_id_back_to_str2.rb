class ChangeTweetUserIdBackToStr2 < ActiveRecord::Migration
  def change
  	remove_column :tweets, :t_id
    add_column :tweets, :t_id, :string
  end
end
