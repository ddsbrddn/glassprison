class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :upvote, :downvote]
  before_action :correct_user, only: :destroy


  def index    
    @microposts = Micropost.paginate(page: params[:page], :per_page => 12)
  end

  def show

    @micropost = Micropost.find(params[:id])
    @comments = Comment.where(micropost_id: @micropost)
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to @micropost
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  def upvote
    @micropost = Micropost.find(params[:id])
    @micropost.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @micropost = Micropost.find(params[:id])
    @micropost.downvote_by current_user
    redirect_to :back
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end


end
