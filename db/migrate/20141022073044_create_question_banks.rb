class CreateQuestionBanks < ActiveRecord::Migration
  def change
    create_table :question_banks do |t|
      t.string :title
      t.text :content
      t.string :tags
      t.string :number, null: false
      t.string :video_url

      t.timestamps
    end

	  add_index :question_banks,	:number, unique: true
  end
end
