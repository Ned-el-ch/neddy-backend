class CategoriesController < ApplicationController
	skip_before_action :authorized, only: [:posts, :index]
	def index
		categories = Category.all
		render json: categories
	end

	def posts
		category = Category.all.find_by(search_term: params[:search_term].downcase)
		if category
			# posts = category.posts
			render json: category.to_json(include: {
				posts: {
					include: {
						user: {
						},
						categories: {
							only: [:id, :title]
						},
						comments: {
							only: [:id, :content],
							include: {
								user: {only: [:username, :name]}
							}
						},
						post_likes: {
							only: [:id, :user_id]
						},
						post_favorites: {
							only: [:id, :user_id]
						}
					}
				},
				users: {
					only: [:id]
				}
			})
		else
			render json: { error: 'failed to retrieve posts lol' }, status: :not_acceptable
		end
	end
end