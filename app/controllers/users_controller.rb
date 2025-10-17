class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update edit destroy ]

  #get /users
  def index
    @users = User.all.decorate
  end

  def new
    @user = User.new
  end

  def edit
  end

  def show
  end

  #post /users 
  def create
    @user = Users::UserUsecase.new(user_params)
    response = @user.create
      if response[:status] == :created
        redirect_to users_path, notice: t('messages.common.create_success', data: "User")
      else
        flash[:errors] = response[:errors]
        redirect_to new_user_path, status: :unprocessable_entity
      end
    rescue StandardError => e
      logger.error "There is something wrong in user create. #{e.message}"
      redirect_to new_user_path, alert: "An unexpected error occurred. Please try again."
  end

  #patch/put /user/:id
  def update
    @user = User.find(params[:id])
    usecase = Users::UserUsecase.new(user_params)

    result = usecase.update(@user)

    if result[:status] == :updated
      redirect_to users_path, notice: "User updated successfully."
    else
      flash[:errors] = result[:errors]
      redirect_to edit_user_path(@user), status: :unprocessable_entity
    end
  rescue StandardError => e
    logger.error "Error updating user: #{e.message}"
    redirect_to edit_user_path(@user), alert: "An unexpected error occurred. Please try again."
  end


  #delete /user/:id
  def destroy
      @deleted_user = Users::UserUsecase.new(nil)
      if @deleted_user.destroy(@user)
        redirect_to users_path, notice: "User deleted successfully."
      else
        redirect_to users_path, alert: "Could not delete user."
      end
    rescue StandardError => e
      logger.error "Error deleting user: #{e.message}"
      redirect_to users_path, alert: "An unexpected error occurred. Please try again."
  end

  private
    def set_user
      @user = User.find(params[:id]).decorate
    end

    def user_params
      params.require(:user).permit(:name, :email, :info, :encrypted_password)
    end
end
