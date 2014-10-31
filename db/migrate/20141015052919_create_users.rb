class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login,  null: false
      t.string :email,  null: false
      t.integer :kind,  null: false, default: 1
      t.string :password

      t.timestamps
    end

	  add_index :users,	:email, unique: true
  end
end
