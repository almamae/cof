class AddLikescountTPost < ActiveRecord::Migration
  def change
  	add_column :posts, :likescount, :integer
  end

end