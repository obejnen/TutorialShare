class ChangeStringToTextInTutorial < ActiveRecord::Migration[5.1]
  def up
    change_column :tutorials, :body, :text
  end

  def down
    change_column :tutorials, :body, :string
  end
end
