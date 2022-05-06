class PostsController < ApplicationController

  def index   
    # @posts = Post.paginate(page: params[:page], per_page: 5)
    @posts = Post.all
    # respond_to do |format|
    #   format.html
    #   format.csv { send_data @posts.to_csv(['title','description'])} 
    # end
  end

  def show
    @post = Post.find_by(params[:id])
  end

  def new
  end

  def update
    post = Post.find_by(params[:id])    
    post.update (post_params)

    redirect_to posts_path
  end

  def destroy
    post = Post.find_by(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def edit
    @post = Post.find_by(params[:id])
  end

  def create
    post = Post.new(post_params)
    post.save
    redirect_to posts_path
  end

  def new_confirm
    @post = Post.new(post_params)
  end
  
  def edit_confirm
    @post = Post.find_by(params[:id])
    @post.update (post_params)
    redirect_to posts_path
  end

  def download
    @posts = Post.all
    respond_to do |format|
      format.html
      format.csv { send_data @posts.to_csv(['title','description','status'])} 
    end
  end

  
  def upload
    Post.upload(params[:file])
    redirect_to posts_path, notice: "Posts Uploaded"
  end
 
  private
  def post_params
    params.require(:post).permit(:title, :description)
  end
end