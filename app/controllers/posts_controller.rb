class PostsController < ApplicationController
	def index
	end
	
	def new
		@post = Post.new
	end
	
	def create
		@post = Post.new(params[:post])
		@post.user = current_user
		if(@post.save)
			redirect_to post_path(@post)
		else
			render :action => 'new'
		end
	end
	
	def show
		@post = Post.find(params[:id])
	end
end
