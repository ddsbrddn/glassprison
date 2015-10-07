class StaticPagesController < ApplicationController
  def home
    if logged_in?
    @micropost = current_user.microposts.build
    @feed_items = current_user.feed.paginate(page: params[:page])
    else
    @microposts = Micropost.paginate(page: params[:page], :per_page => 12)

    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def submit
    @micropost = current_user.microposts.build
  end
end
