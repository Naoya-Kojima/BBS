class ChangeTitleRemoveDefaultPost < ActiveRecord::Migration[5.2]
  def up
    remove_column :posts, :title, :string, default: 0
    add_column :posts, :title, :string
    change_column_null :posts, :title, false
  end
end
