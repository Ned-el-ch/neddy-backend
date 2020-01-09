class PostsController < ApplicationController
	skip_before_action :authorized
	def index
		render json: { test: 'test'}, status: :accepted
	end
end