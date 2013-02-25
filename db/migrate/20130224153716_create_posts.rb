class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.integer :user_id
      t.string :category
      t.integer :isApproved, default: 0

      t.timestamps
    end
  end
end
