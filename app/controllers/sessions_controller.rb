class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email]
    if user&.authenticate params[:session][:password]
      log_in user
      flash[:success] = t "pages.signin.success"
      redirect_to user
    else
      flash.now[:danger] = t "pages.signin.danger"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to static_pages_home_path
  end
end
