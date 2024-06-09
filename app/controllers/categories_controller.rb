class CategoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_category, only: %i[show edit update]

  def index
    @categories = Category.all
  end

  def show
    @doctors = Doctor.where(category_id: @category).order(:email)
  end

  def new
    @category = Category.new
    @categories = Category.all.order(:name)
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, success: 'Category was created successfuly'
    else
      @categories = Category.all.order(:name)
      flash.now[:danger] = 'Category was not created'
      render :new
    end
  end

  def edit
    @categories = Category.where("id != #{@category.id}").order(:name)
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, success: 'Category was updated successfuly'
    else
      @categories = Category.where("id != #{@category.id}").order(:name)
      flash.now[:danger] = 'Category was not updated'
      render :edit
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end
end
