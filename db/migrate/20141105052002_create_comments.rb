class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :user_id, index: true
      t.integer :status, null: false, default: 1
      t.integer :relateable_id, index: true
      t.string :relateable_type, index: true

      t.timestamps
    end
  end
end
