class PostsController < ApplicationController
	skip_before_action :authorized, only: [:index, :create, :show]

	def index

		posts = Post.all
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

	def show
		post = Post.find(params[:id])
		render json: post.to_json(include: {
			user: {
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

	def create
		post = Post.new
		# byebug
		post_params[:categories].each do |category_id|
			categoryExists = Category.find(category_id)
			if categoryExists
				post.categories << categoryExists
			end
		end
		post.content = post_params[:content]
		post.title = post_params[:title]
		post.user = User.find(post_params[:user_id])
		post.save

		if post.valid?
			render json: post.to_json(include: {
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
			}), status: :created
		else
			render json: { error: 'failed to create post' }, status: :not_acceptable
		end
	end

	private

	def post_params

		params.require(:post).permit(:id, :content, :title, :user_id, :username, categories: [])

	end

end