class ChangeLikescountInPost < ActiveRecord::Migration
  def change
  	change_column :posts, :likescount, :integer, default: 0
  end

end
