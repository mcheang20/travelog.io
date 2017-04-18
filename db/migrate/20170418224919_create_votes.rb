class CreateVotes < ActiveRecord::Migration[5.0]
  def change
      create_table :votes do |t|
        t.integer :value
        t.references :user, index: true, foreign_key: true
        t.references :log, index: true, foreign_key: true
        t.timestamps null: false
    end
  end
end
