class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :month
      t.string :number
      t.string :title
      t.text :content
      t.string :video_url

      t.timestamps
    end
  end
end
