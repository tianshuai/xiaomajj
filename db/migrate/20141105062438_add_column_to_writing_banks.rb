class AddColumnToWritingBanks < ActiveRecord::Migration
  def change
    add_column :writing_banks, :video_url, :string
  end
end
