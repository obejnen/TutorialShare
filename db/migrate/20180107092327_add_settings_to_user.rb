class AddSettingsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :locale, :string, default: 'ru'
    add_column :users, :theme, :string, default: 'light'
  end
end
