class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.string :name
      t.string :occupation
      t.string :twitter
      t.string :facebook
      t.integer :isBanned     , default: 0
      t.integer :isReported   , default: 0
      t.datetime :dateReported
      t.string :user_type
      t.string :g_plus

      t.timestamps
    end
  end
end
