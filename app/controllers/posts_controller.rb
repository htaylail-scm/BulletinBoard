class PostsController < ApplicationController
  def index
    if params[:search]
      @posts = Post.search(params[:search]).order("created_at DESC")
    else
      @posts = Post.paginate(page: params[:page], per_page: 3)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
  end

  def update
    post = Post.find(params[:id])
    post.update (post_params)

    redirect_to posts_path
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    post = Post.new(post_params)
    post.save
    redirect_to posts_path
  end
  private
  def post_params
      params.require(:post).permit(:title, :description)
  end
end
