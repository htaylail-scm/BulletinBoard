class PostsController < ApplicationController

  def index 
    @posts = Post.paginate(page: params[:page], per_page: 10)
    # @posts = Post.all
    respond_to do |format|
      format.html
      format.csv { send_data @posts.to_csv(['title','description','status'])} 
    end
  end

  def show
    @post = Post.find_by(params[:id])
  end

  def new
    @post = Post.new
  end

  def confirm_create
    @post = Post.new(post_params)
  end

  def create
    post = Post.new(post_params)
    # @post.status = 1
    # post.create_user_id = Current.user.id
    # post.updated_user_id = Current.user.id

    if post.save
      redirect_to posts_path, notice: "Succeffully Post Created!"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def confirm_update
    # post = Post.new(post_update_params)
    @post = Post.find_by(params[:id])    
  end

  def update
    @post = Post.find_by(params[:id])    
    if @post.update(post_update_params)
      redirect_to posts_path, notice: "Post Updated!"
    else
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
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
    
  # def search(search)
  #   @posts = Post.search(params[:search])
  #   @posts = Post.where("lower(title) LIKE ?", "%#{search.downcase}%")
  # end

  private
  def post_params
    params.require(:post).permit(:title, :description)
  end

  def post_update_params
    params.require(:post).permit(:title, :description, :status)
  end
 

end