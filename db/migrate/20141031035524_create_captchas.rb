class CreateCaptchas < ActiveRecord::Migration
  def change
    create_table :captchas do |t|
      t.string :title
      t.string :code
      t.integer :kind,  null: false, default: 1
      t.integer :expires_at
      t.integer :user_id, null: false
      t.timestamps
    end

    add_index :captchas,  :code
    add_index :captchas,  :user_id
    add_index :captchas,  :expires_at

  end
end
