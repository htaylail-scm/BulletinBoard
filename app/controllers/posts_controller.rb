class PostsController < ApplicationController

  def index 
    # @posts = Post.paginate(page: params[:page], per_page: 5)
    @posts = Post.all
    respond_to do |format|
      format.html
      format.csv { send_data @posts.to_csv(['title','description'])} 
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
    post.save
    redirect_to posts_path
  end
  
  # def new
  #   @post = Post.new
  # end

  # def confirm_create
  #   @post = Post.new(post_params)
  #   unless @post.valid?
  #       render :new
  #   end
  # end

  # def create
  #   @post = Post.new(post_params)
  #   @post.status = 1
  #   @post.create_user_id = current_user.id
  #   @post.updated_user_id = current_user.id

  #   if @post.save
  #     redirect_to posts_path, notice: "Post Created!"
  #   else
  #     render :new
  #   end
  # end

  def edit
    @post = Post.find(params[:id])
  end

  def confirm_update
    @post = Post.find(params[:format])
    # @post.updated_user_id = current_user.id
     @post.update(post_params)
     
    if @post.update(post_params)
      redirect_to posts_path, notice: "Post Updated!"
    else
      render :edit
    end
  end

  def update
    post = Post.find_by(params[:id])    
    post.update (post_params)

  end

 

  # def confirm_update
  #   @post = Post.find(params[:format])
  #   # @post.updated_user_id = current_user.id
  #   @post.update(post_params)
  # end

  # def update
  #   # post = Post.find_by(params[:id])    
  #   # post.update (post_params)
  #   # redirect_to posts_path

  #   @post = Post.find(params[:id])
  #   # @post.updated_user_id = current_user.id

  #   if @post.update(post_params)
  #     redirect_to posts_path, notice: "Post Updated!"
  #   else
  #     render :edit
  #   end
  # end


  # def edit
  #   @post = Post.find(params[:id])
  # end

  # def confirm_update
  #   @post = Post.new(post_update_params)
  #   unless @post.valid?
  #       render :edit
  #   end
  # end

  # def update
    # @post = Post.find(params[:id])
    # @post.updated_user_id = current_user.id

    # if @post.update(post_update_params)
    #   redirect_to @post, notice: "Post Updated!"
    # else
    #   render :edit
    # end
  # end

  
  def destroy
    post = Post.find_by(params[:id])
    post.destroy
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

end