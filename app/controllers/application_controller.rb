class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  before_filter :set_cache_buster

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def current_user
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


  protected
  def authorize
      unless User.find_by_id(session[:user_id])
		    redirect_to login_url, :notice => "Please log in"
	  end
  end

  # def countlikes(post)
  #   Flagging.where("flaggable_type LIKE Post" && flaggable_id = post.id)
  # end

  def isadmin
    unless current_user.user_type == "admin"
      redirect_to home_url
    end    
  end
end
