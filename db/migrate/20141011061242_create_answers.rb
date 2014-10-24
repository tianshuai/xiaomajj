class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :tip
      t.string :audio_url
      t.string :audio_length
      t.references :question_bank, index: true

      t.timestamps
    end
  end
end
