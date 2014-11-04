class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.string :title, null: false
      t.text :content
      t.string :mark, null: false
      t.integer :status,  null: false, default: 1

      t.timestamps
    end

	  add_index :blocks,	:mark, unique: true
  end
end
