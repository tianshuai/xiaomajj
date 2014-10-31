class CreateWriteRecords < ActiveRecord::Migration
  def change
    create_table :write_records do |t|
      t.text :content
      #类型：1，独立；2，综合
      t.integer :kind, null: false, default: 1
      t.integer :user_id, null: false
      t.integer :writing_bank_id, null: false
      #状态
      t.integer :status,  null: false,  default: 1
      #是否允许老师批阅
      t.integer :is_amend,  null: false,  default: 0
      #是否可以修改
      t.integer :is_modify, null: false,  default: 1

      t.timestamps
    end

	  add_index :write_records,	:user_id
	  add_index :write_records,	:writing_bank_id
  end
end
