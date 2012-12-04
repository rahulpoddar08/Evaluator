class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :content
      t.integer :evaluation_id

      t.timestamps
    end
  end
end
