class BlogsController < ApplicationController
	def myBlog
		render 'blogs/my_blog'
	end

	def following
		render 'blogs/following_blog'
	end
end
