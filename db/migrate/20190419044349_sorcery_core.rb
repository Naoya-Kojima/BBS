class SorceryCore < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email, :string
    add_index :users, :email, :unique => true
    change_column :users, :email, :string, null: false
    add_column :users, :crypted_password, :string
    add_column :users, :salt, :string
  end
end
