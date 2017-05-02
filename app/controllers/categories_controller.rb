class CategoriesController < ApplicationController
  def show
    @categories = Category.all
    @category = Category.find(params[:id])
  end

  def new
   @category = Category.new
  end

  def create
    @category = Category.new(category_params)
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end
