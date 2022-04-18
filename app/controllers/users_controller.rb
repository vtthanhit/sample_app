class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(create new show)
  before_action :find_user, except: %i(create new index)
  before_action :correct_user, only: %i(edit update)

  def index
    @pagy, @users = pagy(User.all, items: Settings.pagy_items_10)
  end

  def new
    @user = User.new
  end

  def show
    @pagy, @microposts = pagy(@user.microposts, items: Settings.pagy_items_5)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".info"
      redirect_to static_pages_home_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".success"
      redirect_to @user
    else
      render :edit
      flash[:danger] = t ".danger"
    end
  end

  def destroy
    if @user&.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".danger"
    end
    redirect_to users_path
  end

  private
  def user_params
    params
      .require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    redirect_to static_pages_home_path unless current_user? @user
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "pages.user.not_found"
    redirect_to static_pages_home_path
  end
end
