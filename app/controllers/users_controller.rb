class UsersController < ApplicationController
	 def new
  		@user = User.new
      
	end

	def create
  		@user = User.new(params[:user])
  		if @user.save
    		session[:user_id] = @user.id
        redirect_to posts_path, :notice => "Signed up!"
  		else
    		render "new"
  		end
	end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def index
    authorize
    @users = User.order("created_at desc")
  end

  def edit
    authorize
    @user = User.find(params[:id])
  end
  
  def update
    authorize
    @user = User.find(params[:id])
    

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to user_path(@user), notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize
    @user = User.find(params[:id])
    @user.destroy
    
    redirect_to users_path :notice=> "User has been deleted"
  end 

end
