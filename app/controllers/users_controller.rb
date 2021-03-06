class UsersController < ApplicationController
  
  before_action :require_user_logged_in, only: [:index,:show]
  
  
  def index
    @users= User.all.page(params[:page])
  end

  def show
    @user= User.find(params[:id])
    @posts= @user.posts.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def new
    @user= User.new
  end

  def create
    @user= User.new(user_params)
    if @user.save
      flash[:success]="ユーザーを登録成功"
      redirect_to @user
    else
      flash[:danger]="ユーザーを登録失敗"
      render :new
    end
  end
  
  def likes
    @user= User.find(params[:id])
    @posts= @user.fav_posts.order('created_at DESC').page(params[:page])
    counts(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
