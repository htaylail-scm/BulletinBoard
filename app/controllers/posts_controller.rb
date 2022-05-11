class PostsController < ApplicationController

  # def index 
  #   @posts = Post.paginate(page: params[:page], per_page: 10)
  #   # @posts = Post.all
  #   respond_to do |format|
  #     format.html
  #     format.csv { send_data @posts.to_csv(['title','description','status'])} 
  #   end
  # end

  def index
      if params[:search]
        @posts = Post.where(["title LIKE ? OR description like?","%#{params[:search]}%","%#{params[:search]}%"])
      else
        @posts = Post.all
      end
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
      redirect_to posts_path, notice: "Successfully Post Created!"
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
      format.csv { send_data @posts.to_csv(['title','description'])} 
    end
  end

  def upload
    if params[:file].present?
      Post.upload(params[:file])
      redirect_to posts_path, notice: "CSV Imported"
    else
      redirect_to posts_path, notice: "You need to choose a file first!"
    end
  end

  # def import
  #   Post.import(params[:file])
  #   redirect_to posts_path
  # end

  # def upload
  #   updated_user_id = current_user.id
  #   create_user_id = current_user.id
  #   if (params[:file].nil?)
  #       redirect_to upload_posts_path, notice: "Require File"        
  #   elsif !File.extname(params[:file]).eql?(".csv")
  #       redirect_to upload_posts_path, notice: "Wrong File Type"  
  #   else
  #       error_msg = PostsHelper.check_header(["title", "description", "status"],params[:file])
  #       if error_msg.present?
  #           redirect_to upload_posts_path, notice: error_msg
  #       else 
  #           Post.import(params[:file],create_user_id,updated_user_id)
  #           redirect_to posts_path, notice: "Imported Successfully!"
  #       end
  #   end
  # end

  # def search(search)
  #   if search
  #       where(["title LIKE ? OR description LIKE ","%#{params[:search]}%","%#{params[:search]}%"])
  #   else
  #       all
  #   end
  # end 


  private
  def post_params
    params.require(:post).permit(:title, :description)
  end

  def post_update_params
    params.require(:post).permit(:title, :description, :status)
  end
 

end