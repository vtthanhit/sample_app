class StaticPagesController < ApplicationController
  rescue_from Pagy::OverflowError, with: :redirect_to_last_page

  def home
    return unless logged_in?

    @micropost = current_user.microposts.build
    @pagy, @feed_items = pagy(@current_user.feed,
                              items: Settings.pagy_items_5)
  end

  def help; end

  private
  def redirect_to_last_page exception
    redirect_to url_for(page: exception.pagy.last)
  end
end
