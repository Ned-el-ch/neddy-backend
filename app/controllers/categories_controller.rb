class CategoriesController < ApplicationController
	skip_before_action :authorized, only: [:posts]
	def posts
		category = Category.all.find(params[:id])

		if category.valid?
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