class PostsController < ApplicationController
    def index
        @posts = Post.all
    end 
    
    def show
        @post = Post.find_by(params[:id])
    end

    def new
        @post = Post.new
    end

    private
    def post_params
        params.require(:post).permit(:title, :description)
    end

end