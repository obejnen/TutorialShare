class AddCategoryIdToTutorials < ActiveRecord::Migration[5.1]
  def change
    add_column :tutorials, :category_id, :integer
    add_index :tutorials, :category_id
  end
end
