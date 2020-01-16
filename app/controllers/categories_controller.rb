class CategoriesController < ApplicationController
	skip_before_action :authorized, only: [:posts, :index]
	def index
		categories = Category.all
		render json: categories
	end

	def posts
		category = Category.all.find_by(search_term: params[:search_term].downcase)
		if category
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
		else
			render json: { error: 'failed to create post' }, status: :not_acceptable
		end
	end
end