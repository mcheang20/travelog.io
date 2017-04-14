class AddLogColumnsToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :logs, :category_id, :integer
  end
end
