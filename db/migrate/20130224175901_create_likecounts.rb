class CreateLikecounts < ActiveRecord::Migration
  def change
    create_table :likecounts do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
  end
end
