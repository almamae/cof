class Post < ActiveRecord::Base
  CATEGORIES = [  "Dish",  "Pastry", "Dessert", "Appetizer"] 
  attr_accessible :content, :title, :user_id, :recipe_id, :category, :likescount
  belongs_to :user
  make_flaggable :like
  validates_presence_of :content, :title, :category, :on => :create 
  validates :category, :inclusion => CATEGORIES

  def self.showcategory(cat)
  	where('category LIKE ?', cat)
  end

  def self.unapproved()
    where(isApproved = nil)
  end

  def self.approved()
    where(isApproved = 1)
  end

  def post
    return @post if defined?(@post)
    @post = commentable.is_a?(Post) ? commentable : commentable.post
  end
end
