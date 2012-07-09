class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :followers
      t.integer :followers_delta
      t.integer :following
      t.integer :rts
      t.integer :rts_today
      t.integer :mentions
      t.integer :mentions_today

      t.timestamps
    end
  end
end
