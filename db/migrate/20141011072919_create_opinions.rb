class CreateOpinions < ActiveRecord::Migration
  def change
    create_table :opinions do |t|
      t.string :content
      t.references :user, index: true
      t.references :question_bank, index: true

      t.timestamps
    end
  end
end
