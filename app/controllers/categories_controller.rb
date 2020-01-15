class CategoriesController < ApplicationController
	skip_before_action :authorized, only: [:posts]
	def posts
		byebug
		category = Category.all.find(params[:id])
		posts = category.posts
		render json: posts.to_json(include: {
			user: {
				only: [:id, :name, :username, :bio]
			},
			categories: {
				only: [:id, :title]
			},
			comments: {
				only: [:id, :content, :user_id]
			},
			post_likes: {
				only: [:id, :user_id]
			},
			post_favorites: {
				only: [:id, :user_id]
			}
		})
	end
end