class ToppagesController < ApplicationController
  def index
#    @new_posts= Post.order('created_at DESC').page(params[:page])
    @posts= Post.order('created_at DESC').page(params[:page])
    @no1= Like.ranking.keys.try!(:first)
    @post=  Post.find_by(id: @no1)
  end
end
