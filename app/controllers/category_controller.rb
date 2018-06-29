class CategoryController < ApplicationController
  def create
    @category = current_user.category.build(post_params)
    if @category.save
        redirect_to root_path
    else
        render :new
    end
  end

  def destroy
      Category.find(params[:id]).destroy
      redirect_to root_path
  end

  def edit
  end
end
