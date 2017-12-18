class CreateJoinTableUserTutorials < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :tutorials do |t|
      t.index :user_id
      t.index :tutorial_id
    end
  end
end
