class PostsController < ApplicationController
  before_action :check, only: :destroy
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
        redirect_to root_path
    else
        render :new
    end
  end

  def destroy
      Post.find(params[:id]).destroy
      redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :expense)
  end

  def check
    unless current_user?(Post.find(params[:id]).user.id)
        flash[:danger] = "Error 404 not found"
        redirect_to root_path
    end
  end
end
