class BlogsController < ApplicationController
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
end
