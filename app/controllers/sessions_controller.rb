class SessionsController < ApplicationController
  before_action :find_user, only: :create

  def new; end

  def create
    if @user&.authenticate params[:session][:password]
      log_in @user
      params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
      flash[:success] = t "pages.signin.success"
      redirect_back_or @user
    else
      flash.now[:danger] = t "pages.signin.danger"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to static_pages_home_path
  end

  private
  def find_user
    @user = User.find_by email: params.dig(:session, :email)
    return if @user

    flash.now[:danger] = t "pages.signin.not_exist_email"
    render :new
  end
end
