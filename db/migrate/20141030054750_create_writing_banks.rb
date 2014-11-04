class CreateWritingBanks < ActiveRecord::Migration
  def change
    create_table :writing_banks do |t|
      t.string :title
      t.text :content
      #1,独立；2.综合
      t.integer :kind, null: false, default: 1
      t.integer :status,  null: false, default: 1
      t.string :number, null: false
      t.string :tags
      t.timestamps
    end

	  add_index :writing_banks,	:number, unique: true
  end
end
