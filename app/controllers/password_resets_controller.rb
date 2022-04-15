class PasswordResetsController < ApplicationController
  before_action :find_user, :valid_user, :check_expiration,
                only: %i(edit update)

  def new; end

  def edit; end

  def create
    @user = User.find_by email: params.dig(:password_reset, :email)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "pages.reset_password.reset_password_info"
      redirect_to static_pages_home_path
    else
      flash.now[:danger] = t "pages.signin.not_exist_email"
      render :new
    end
  end

  def update
    if @user.update user_params
      log_in @user
      @user.update reset_digest: nil
      flash[:success] = t ".success"
      redirect_to @user
    else
      flash.now[:danger] = t ".danger"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def find_user
    @user = User.find_by email: params[:email]
    return if @user

    flash[:danger] = t "pages.user.not_found"
    redirect_to static_pages_home_path
  end

  def valid_user
    return if @user.activated && @user.authenticated?(:reset, params[:id])

    flash[:danger] = t "pages.reset_password.errors"
    redirect_to static_pages_home_path
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t "pages.reset_password.expired"
    redirect_to new_password_reset_path
  end
end
