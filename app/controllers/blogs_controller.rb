class BlogsController < ApplicationController
	def myBlog
		render 'blogs/my_blog'
	end

	def following
		render 'blogs/following_blog'
	end

	def browse
		render 'blogs/browse'
	end

	def post
		
		@blog = BlogEntry.new
		title = params["title"]
		des = params["textarea"]
		user_id = current_user.id

		@blog.title = title
		@blog.description = des
		@blog.user_id = user_id
		if @blog.save 
			render 'blogs/my_blog'
		else
			render 'blogs/browse'
		end
	end
end
