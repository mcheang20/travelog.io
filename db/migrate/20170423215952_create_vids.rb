class CreateVids < ActiveRecord::Migration[5.0]
  def change
    create_table :vids do |t|
      t.string :caption
      t.timestamps
    end
  end
end
