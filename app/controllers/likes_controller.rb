class LikesController < ApplicationController
  def create
#    post= Post.find_by(params[:post_id]) 
    post= Post.find(params[:post_id])
    current_user.favo(post)
    flash[:success]= "お気に入りしました"
    redirect_to root_url
  end

  def destroy
    post= Post.find(params[:post_id])
    current_user.unfavo(post)
    flash[:success]= "お気に入りから外しました"
    redirect_to root_url
  end
end
