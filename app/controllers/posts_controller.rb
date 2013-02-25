class PostsController < ApplicationController
		skip_before_filter :authorize, only: [:new, :create,:edit,:destroy]

	def index 
		@post = Post.new
		@posts = Post.order("created_at desc").paginate(:per_page => 2, :page => params[:page])
	end
	
	def show
		@post = Post.find(params[:id])
		@parent = @post

	end 

	def new
		@post = Post.new		
	end

	def create
		authorize
		@post = Post.new(params[:post])

		if @post.save
			redirect_to myposts_path, :notice => "Your post was saved"
		else 
			render "new"
		end	
	end
	
	def edit
		authorize
		@post = Post.find(params[:id])
	end
	
	def update
		authorize
		@post = Post.find(params[:id])
	
		if @post.update_attributes(params[:post])	
			redirect_to myposts_path, :notice =>"Your post has been updated"
		else
			render "edit"
		end
	end

	def like
		@current_user = current_user
		@post = Post.find(params[:id]) 
		if @current_user.flagged?(@post, :like)
			@current_user.unflag(@post, :like)
			@post.decrement(:likescount)
			@post.save	
		else
			@current_user.flag(@post, :like)
			@post.increment(:likescount)
			@post.save
		end

		redirect_to post_path(@post)
	end
	
	def destroy
		authorize
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to myposts_path :notice=> "Your post has been deleted"
	end	

	def myposts
		authorize
		@posts = current_user.posts.order("created_at desc").paginate(:per_page => 2, :page => params[:page]) 
	end

	def pastry
		@posts = Post.showcategory("Pastry").paginate(:per_page => 5, :page => params[:page])
	end

	def dish
		@posts = Post.showcategory("Dish").paginate(:per_page => 5, :page => params[:page])
	end

	def appetizer
		@posts = Post.showcategory("Appetizer").paginate(:per_page => 5, :page => params[:page])
	end

	def dessert
		@posts = Post.showcategory("dessert").paginate(:per_page => 5, :page => params[:page])
	end

end
