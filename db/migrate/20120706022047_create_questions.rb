class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :q_id
      t.integer :lesson_id
      t.text :question
      t.string :answer
      t.text :tweet
      t.string :url
      t.string :short_url

      t.timestamps
    end
  end
end
