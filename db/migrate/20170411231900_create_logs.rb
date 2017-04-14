class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.string :title
      t.text :body
      t.text :description
      t.boolean :private
      t.boolean :public, default: true
      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
