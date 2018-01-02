class ChangeDefaultValueImage < ActiveRecord::Migration[5.1]
  def change
    change_column :tutorials, :image, :string, default: "default_image.png"
  end
end
