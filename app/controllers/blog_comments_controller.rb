class BlogCommentsController < ApplicationController
	before_action :logged_in_user

	def create
		@blog = Blog.find(params[:blog_id])
		@blog_comment = BlogComment.create(params[:blog_comment].permit(:content))
		@blog_comment.user_id = current_user.id
		@blog_comment.blog_id = @blog.id

		if @blog_comment.save
			redirect_to blog_path(@blog)
		else
			render 'new'
		end
	end
end
