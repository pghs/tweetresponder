class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :t_name
      t.integer :t_id
      t.string :t_screen_name
      t.integer :lifetime_score
      t.integer :weekly_score

      t.timestamps
    end
  end
end
