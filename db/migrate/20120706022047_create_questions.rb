class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :q_id
      t.integer :lesson_id
      t.text :question
      t.text :answer
      t.text :tweet
      t.text :url
      t.text :short_url

      t.timestamps
    end
  end
end
