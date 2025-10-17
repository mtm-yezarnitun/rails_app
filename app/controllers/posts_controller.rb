class PostsController < ApplicationController
  before_action :set_post, only: %i[ show update edit destroy ]
  before_action :set_categories, only: %i[ new show update edit destroy ]
  #get /posts
  def index
    @posts = Post.includes(:category).all
  end

  def new
    @post = Post.new
  end

  def edit
    @post
  end

  def show
    @post
  end

  #post /posts 
  def create
    @post = Posts::PostUsecase.new(post_params)
    response = @post.create

    if response[:status] == :created
      redirect_to posts_path, notice: t('messages.common.create_success', data: "Post")
    else
      flash[:errors] = response[:errors]
      redirect_to new_post_path, status: :unprocessable_entity
    end

    rescue StandardError => e
      logger.error "There is something wrong in post create. #{e.message}"
      redirect_to new_post_path, alert: "An unexpected error occurred. Please try again."
  end

  #patch/put /post/:id 
  def update
    @post = Post.find(params[:id])
    usecase = Posts::PostUsecase.new(post_params)

    result = usecase.update(@post)

    if result[:status] == :updated
      redirect_to posts_path, notice: "Post updated successfully."
    else
      flash[:errors] = result[:errors]
      redirect_to edit_post_path(@post), status: :unprocessable_entity
    end
  rescue StandardError => e
    logger.error "Error updating post: #{e.message}"
    redirect_to edit_post_path(@post), alert: "An unexpected error occurred. Please try again."
  end

  #delete /post/:id
  def destroy
      @deleted_post = Posts::PostUsecase.new(nil)
      if @deleted_post.destroy(@post)
        redirect_to posts_path, notice: "Post deleted successfully."
      else
        redirect_to posts_path, alert: "Could not delete post."
      end
    rescue StandardError => e
      logger.error "Error deleting post: #{e.message}"
      redirect_to posts_path, alert: "An unexpected error occurred. Please try again."
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def set_categories
      @categories = Category.all
    end
    
    def post_params
      params.require(:post).permit(:title, :message, :category_id)
    end
end
