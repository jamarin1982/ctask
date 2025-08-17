class CategoriesController < ApplicationController
  before_action :authorize!
  def index
    @categories = Category.all.order(name: :asc).load_async
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_url, notice: t(".created")
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    category
  end

  def update
    if category.update(category_params)
      redirect_to categories_url, notice: t(".updated")
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    category.destroy
    redirect_to categories_url, notice: t(".destroyed"), status: :see_other
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def category
    @category ||= Category.find(params[:id])
  end
end
