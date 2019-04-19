class SorceryCore < ActiveRecord::Migration[5.2]
  def up
    drop_table :users

    create_table :users do |t|
      t.string :name,             :null => false
      t.string :email,            :null => false
      t.integer :sex,             :null => false
      t.string :crypted_password
      t.string :salt

      t.timestamps                :null => false
    end

    add_index :users, :email, unique: true
  end
end
