class CreateJoinTableTutorialTags < ActiveRecord::Migration[5.1]
  def change
    create_join_table :tutorials, :tags do |t|
      t.index :tutorial_id
      t.index :tag_id
    end
  end
end
