class PostsController < ApplicationController
  
#  before_action :currect_user, only: [:destroy]
  
  def new
    @post= current_user.posts.new
  end
  
  def show
    @post= Post.find_by(id: params[:id])
    if !@post
      redirect_to root_path
    end
  end

  
  def create
    @post=current_user.posts.new(post_params)
    image_data = Magick::Image.read(@post.image.file.file).first
    @date= image_data.get_exif_by_entry('DateTime')[0][1] 
    @lat= image_data.get_exif_by_entry('GPSLatitude')[0][1]
    @lng= image_data.get_exif_by_entry('GPSLongitude')[0][1]
    if @lat && @lng
      @lat=@lat.split(',').map(&:strip)
      @lng=@lng.split(',').map(&:strip)
      @ido= (Rational(@lat[0]) + Rational(@lat[1])/60 + Rational(@lat[2])/3600).to_f
      @keido= (Rational(@lng[0]) + Rational(@lng[1])/60 + Rational(@lng[2])/3600).to_f
      @idokeido= @ido.to_s + "," + @keido.to_s
    end
    if @idokeido
      @post.location= @idokeido
    end
    if @date
      @post.date = @date.sub(":","/").sub(":","/")
    end
    if @post.save
      flash[:success]= "投稿成功"
      redirect_to @post
    else
      flash[:danger]= "投稿失敗"
      render "new"
    end
  end

  def destroy
    @post = current_user.posts.find_by(id: params[:id])
    @post.destroy
    flash[:success]="投稿を削除しました"
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def post_params
    params.require(:post).permit(:location, :image)
  end
  
#  def correct_user   #いるか？
#    @post = current_user.posts.find_by(id: params[:id])
#    if !@post
#      redirect_to root_url
#    end
#  end
  
end
