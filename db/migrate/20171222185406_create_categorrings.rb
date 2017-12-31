class CreateCategorrings < ActiveRecord::Migration[5.1]
  def change
    create_table :categorrings do |t|
      t.belongs_to :tutorial, foreign_key: true
      t.belongs_to :category, foreign_key: true

      t.timestamps
    end
  end
end
