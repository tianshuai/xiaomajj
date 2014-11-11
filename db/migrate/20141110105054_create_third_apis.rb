class CreateThirdApis < ActiveRecord::Migration
  def change
    create_table :third_apis do |t|
      t.string :uid,  index: true
      t.integer :user_id, index: true
      t.string :access_token, index: true
      t.integer :expires_in
      t.integer :kind, null: false, default: 1
      t.string :refresh_token
      t.integer :status, null: false, default: 1

      t.timestamps
    end
  end
end
