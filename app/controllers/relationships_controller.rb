class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :find_user, only: :create
  before_action :find_relationship, only: :destroy

  def create
    current_user.follow @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = @relationship.followed
    current_user.unfollow @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  private
  def find_user
    @user = User.find_by id: params[:followed_id]
    return if @user

    flash[:danger] = t "pages.user.not_found"
    redirect_to static_pages_home_path
  end

  def find_relationship
    @relationship = Relationship.find_by(id: params[:id])
    return if @relationship

    flash[:danger] = t "pages.user.relation_not_found"
    redirect_to static_pages_home_path
  end
end
