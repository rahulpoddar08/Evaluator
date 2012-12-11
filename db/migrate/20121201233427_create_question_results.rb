class CreateQuestionResults < ActiveRecord::Migration
  def change
    create_table :question_results do |t|
      t.integer :Answer
      t.integer :question_id

      t.timestamps
    end
  end
end
