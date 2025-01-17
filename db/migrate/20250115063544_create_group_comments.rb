class CreateGroupComments < ActiveRecord::Migration[6.1]
  def change
    create_table :group_comments do |t|
      t.integer :group_id
      t.integer :group_user_id
      t.integer :group_post_id
      t.text :group_comment

      t.timestamps
    end
  end
end
