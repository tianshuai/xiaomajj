class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :audio_url
      t.string :audio_length
      t.references :user, index: true
      t.references :question_bank, index: true

      t.timestamps
    end
  end
end
