class ChangeTitleToNullFalsePosts < ActiveRecord::Migration[5.2]
  def up
    change_column_null :posts, :title, false, 0
    change_column :posts, :title, :string, default: 0
  end
end
