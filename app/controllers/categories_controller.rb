class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show update edit destroy ]
  
  #get /categories
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit
    @category
  end

  def show
    @category
  end

  #category /categories 
  def create
    @category = Categories::CategoryUsecase.new(category_params)
    response = @category.create

    if response[:status] == :created
      redirect_to categories_path, notice: t('messages.common.create_success', data: "Category")
    else
      flash[:errors] = response[:errors]
      redirect_to new_category_path, status: :unprocessable_entity
    end

    rescue StandardError => e
      logger.error "There is something wrong in category create. #{e.message}"
      redirect_to new_category_path, alert: "An unexpected error occurred. Please try again."
  end

  #patch/put /category/:id 
  def update
    @category = Category.find(params[:id])
    usecase = Categories::CategoryUsecase.new(category_params)

    result = usecase.update(@category)

    if result[:status] == :updated
      redirect_to categories_path, notice: "Category updated successfully."
    else
      flash[:errors] = result[:errors]
      redirect_to edit_category_path(@category), status: :unprocessable_entity
    end
  rescue StandardError => e
    logger.error "Error updating category: #{e.message}"
    redirect_to edit_category_path(@category), alert: "An unexpected error occurred. Please try again."
  end

  #delete /category/:id
  def destroy
      @deleted_category = Categories::CategoryUsecase.new(nil)
      if @deleted_category.destroy(@category)
        redirect_to categories_path, notice: "Category deleted successfully."
      else
        redirect_to categories_path, alert: "Could not delete category."
      end
    rescue StandardError => e
      logger.error "Error deleting post: #{e.message}"
      redirect_to categories_path, alert: "An unexpected error occurred. Please try again."
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end
    
    def category_params
      params.require(:category).permit(:name)
    end
end
