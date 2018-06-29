class PostsController < ApplicationController
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to :new
    else
      render :new
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :expense)
  end
end
