class AddPasswordDigestUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :crypted_password, :string
    add_column :users, :password_digest, :string
  end
end
