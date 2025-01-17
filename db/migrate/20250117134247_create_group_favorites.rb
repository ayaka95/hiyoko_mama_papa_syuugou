class CreateGroupFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :group_favorites do |t|
      t.integer :group_user_id
      t.integer :group_post_id

      t.timestamps
    end
  end
end
