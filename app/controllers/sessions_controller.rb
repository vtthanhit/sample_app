class SessionsController < ApplicationController
  before_action :find_user, only: :create

  def new; end

  def create
    return unless @user&.authenticate params[:session][:password]

    if @user.activated
      log_in @user
      params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
      flash[:success] = t "pages.signin.success"
      redirect_back_or @user
    else
      flash[:warning] = t "pages.signin.warning"
      redirect_to static_pages_home_path
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
