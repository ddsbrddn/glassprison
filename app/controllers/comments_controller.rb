class CommentsController < ApplicationController
	before_action :logged_in_user

	def create
		@micropost = Micropost.find(params[:micropost_id])
		@comment = Comment.create(params[:comment].permit(:content))
		@comment.user_id = current_user.id
		@comment.micropost_id = @micropost.id

		if @comment.save
			redirect_to micropost_path(@micropost)
		else
			render 'new'
		end
	end
end
