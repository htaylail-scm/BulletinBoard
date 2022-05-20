class PostsController < ApplicationController

  before_action :authorized, only: [:new, :edit, :destroy]

  def index
    if params[:search]
      @posts = Post.where(["title LIKE ? OR description like? OR created_user_id like? OR created_at like?",
              "%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%"])
              .paginate(page: params[:page], per_page: 5)
    else
      @posts = Post.paginate(page: params[:page], per_page: 5)
    end
    respond_to do |format|
        format.html
        format.csv { send_data @posts.to_csv(['title','description','status','created_user_id','updated_user_id'])} 
    end
  end
 

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def confirm_create
    @post = Post.new(post_params)
  end

  def create
    @post = Post.new(post_params)
    @post.status = 1
    @post.created_user_id = current_user.id
    @post.updated_user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: "Post isCreated!"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def confirm_update   
    @post = Post.find_by(params[:id])
    @post.title = post_update_params[:title]
    @post.description = post_update_params[:description]
    unless @post.valid? # if !@post.valid?
      render :edit
    end  
  end

  def update
    @post = Post.find(params[:id])  
    @post.updated_user_id = current_user.id
    if @post.update(post_update_params)
      redirect_to posts_path, notice: "Post Updated!"
    else
      render :edit
    end
  end  

  def destroy   
    @post = Post.find(params[:id])
    @post.deleted_user_id = current_user.id
    @post.save # @post.update( 'deleted_user_id' => current_user.id )
    @post.destroy
    redirect_to posts_path, notice: "Post delete Successfully."
  end

  def download
    @posts = Post.all
    respond_to do |format|
      format.html
      format.csv { send_data @posts.to_csv(['title','description','status','created_user_id','updated_user_id'])} 
    end
  end


  def upload
    updated_user_id ||= current_user.id
    created_user_id ||= current_user.id
    if params[:file].present?
      if !(params[:file].content_type == "text/csv")
        redirect_to posts_path, alert: "Only csv accept"
      else       
        Post.upload(params[:file],updated_user_id,created_user_id)
        redirect_to posts_path, notice: "CSV Imported"
      end
    else
      redirect_to posts_path, alert: "Please choose csv file!"
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :description)
  end

  def post_update_params
    params.require(:post).permit(:title, :description, :status)
  end 

end