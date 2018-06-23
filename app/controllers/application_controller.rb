class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  def counts(user)
    @count_posts = user.posts.count
    @count_likes = user.fav_posts.count
  end
  

  private
  
  def require_user_logged_in
    if !logged_in?
      redirect_to login_path
    end
  end
end
