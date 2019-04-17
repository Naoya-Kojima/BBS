class AddColumnToPost < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :user_id, :integer
    add_reference :posts, :user, foreign_key: true
  end
end
