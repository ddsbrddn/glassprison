class BlogsController < ApplicationController
	before_action :logged_in_user, except: [:index, :show]
	before_action :admin_user, only: [:new, :create, :edit, :destroy]

	def index
		@blogs = Blog.all.order('created_at DESC')
	end

	def new
		@blog = Blog.new
	end

	def create
		@blog = Blog.new(blog_params)
		if @blog.save
			redirect_to @blog
		else
			render 'new'
		end
	end

	def show
		@blog = Blog.find(params[:id])
		@blog_comments = BlogComment.where(blog_id: @blog)
	end

	def edit
		@blog = Blog.find(params[:id])
	end

	def update
		@blog = Blog.find(params[:id])

		if @blog.update(params[:blog].permit(:title, :body))
			redirect_to @blog
		else
			render 'edit'
		end
	end

	def destroy
		@blog = Blog.find(params[:id])
		@blog.destroy

		redirect_to blogs_path
	end

	private
	def blog_params
		params.require(:blog).permit(:title, :body)
	end

	# Confirms an admin user.
	def admin_user
		redirect_to(root_url) unless current_user.admin?
	end

end
