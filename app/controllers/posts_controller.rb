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

    def create
        # @post = Post.new(title: "...", description: "..")
        @post = Post.new(post_params)

        if @post.save 
            redirect_to @post
        else
            render :new, status: :unprocessabel_entity
            # render :new
        end
    end

    def edit
        @post = Post.find_by(params[:id])
        if @post.update(post_params)
            redirect_to @post
        else
            render :edit, status: :unprocessabel_entity
        end
    end

    def destory
        @post = Post.find_by(parma[:id])
        @post.destory
    end
    
    private
    def post_params
        params.require(:post).permit(:title, :description)
    end

end