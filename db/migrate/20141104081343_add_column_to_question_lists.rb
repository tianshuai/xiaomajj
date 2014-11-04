class AddColumnToQuestionLists < ActiveRecord::Migration
  def change
    add_column :question_lists, :alone_number_ids, :string
    add_column :question_lists, :synthetical_number_ids, :string
    add_column :question_lists, :status, :integer, null: false, default: 1

    add_index :question_lists,  :number_ids
    add_index :question_lists,  :alone_number_ids
    add_index :question_lists,  :synthetical_number_ids
  end
end
