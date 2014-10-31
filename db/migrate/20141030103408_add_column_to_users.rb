class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :status, :integer,  null: false,  default: 1
    change_column :users, :email, :string, null: true
    add_index :users, :login
    add_index :users, :phone
    remove_index :users, :email
    add_index :users, :email
  end
end
