class CreateQuestionLists < ActiveRecord::Migration
  def change
    create_table :question_lists do |t|
      t.integer :year
      t.integer :month
      t.integer :day,   default: 1
      t.integer :kind,  default: 1
      t.string :number_ids

      t.timestamps
    end

	add_index :question_lists,	:year
	add_index :question_lists,	:month
	add_index :question_lists,	:day
  end
end
