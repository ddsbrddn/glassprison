class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :upvote, :downvote]
  before_action :correct_user, only: :destroy


  def index
    if params[:tag]
      @microposts = Micropost.tagged_with(params[:tag])
    else
    @microposts = Micropost.paginate(page: params[:page], :per_page => 12)
    end
  end

  def show
    @micropost = Micropost.find(params[:id])
    @comments = Comment.where(micropost_id: @micropost)
  end

  def create
    #@micropost = Micropost.new(:name => "")
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to @micropost
    else
      @feed_items = []
      render 'static_pages/submit'
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
      params.require(:micropost).permit(:content, :picture, :name, :tag_list, :title)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end


end
