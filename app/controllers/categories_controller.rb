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
			render json: category.to_json(
				include: {
					posts: {
						include: {
							user: {
								only: [:username, :name, :bio]
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
						}#, only: [:content, :title, :created_at]
					},
					users: {
						only: [:id]
					}
				}
			)
		else
			render json: { error: 'failed to retrieve posts lol' }, status: :not_acceptable
		end
	end

	def follow
		user = User.find(category_params[:user_id])
		category = Category.find_by(search_term: category_params[:category].downcase)

		if user && cat
			relation_exists = UserCategory.where(user: user, category: category)
			if relation_exists
				render json: {message: "already following"}
			else
				UserCategory.create(user: user, category: category)
				render json: {response: true}
			end
		else
			render json: {message: "either user or category don't exist (trying to follow)"}
		end
	end

	def unfollow
		user = User.find(category_params[:user_id])
		category = Category.find_by(search_term: category_params[:category].downcase)

		if user && cat
			relation_exists = UserCategory.where(user: user, category: category)
			if relation_exists
				relation_exists.destroy
				render json: {response: false}
			else
				render json: {message: "you weren't following in the first place"}
			end
		else
			render json: {message: "either user or category don't exist (trying to unfollow)"}
		end
	end

	private

	def category_params
		params.require(:category).permit(:category, :user_id)
	end

end