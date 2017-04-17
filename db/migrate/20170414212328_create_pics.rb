class CreatePics < ActiveRecord::Migration[5.0]
  def change
    create_table :pics do |t|
      t.string :caption
      t.references :log, index: true, foreign_key: true
      t.timestamps
    end
  end
end
