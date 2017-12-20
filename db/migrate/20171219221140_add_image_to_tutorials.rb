class AddImageToTutorials < ActiveRecord::Migration[5.1]
  def change
    add_column :tutorials, :image, :string
  end
end
