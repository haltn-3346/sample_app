class UsersController < ApplicationController
  before_action :find_user, except: %i(index new create)
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @pagy, @users = pagy User.all
  end

  def new
    @user = User.new
  end

  def show; end

  def edit; end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".signup_success"
      redirect_to @user
    else
      render :new
    end
  end

  def update
    if @user.update user_params
      flash[:success] = t ".profile_updated_success"
      redirect_to @user
    else
      flash[danger] = t ".profile_updated_failed"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failure"
    end
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user)
          .permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t ".login_request"
    redirect_to login_path
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t ".show.user_not_found"
    redirect_to signup_path
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

  def correct_user
    redirect_to(root_path) unless current_user? @user
  end
end
