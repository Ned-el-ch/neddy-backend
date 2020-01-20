class PostsController < ApplicationController

	skip_before_action :authorized, only: [:index, :show]

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
		# post.comments
		render json: post.to_json(include: {
			user: {
				only: [:id, :name, :username, :bio]
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
		})
	end

	def like
		likeExists = PostLike.find_by(user_id: post_params[:user_id], post_id: post_params[:id])
		if likeExists
			likeExists.destroy
			# render json: {message: "like deleted"}
		else
			PostLike.create(user_id: post_params[:user_id], post_id: post_params[:id])
		end
		post = Post.find(post_params[:id])
		render json: post.post_likes.to_json(include: {})
	end

	def favorite
		favoriteExists = PostFavorite.find_by(user_id: post_params[:user_id], post_id: post_params[:id])
		if favoriteExists
			favoriteExists.destroy
			# render json: {message: "favorite deleted"}
		else
			PostFavorite.create(user_id: post_params[:user_id], post_id: post_params[:id])
		end
		post = Post.find(post_params[:id])
		render json: post.post_favorites.to_json(include: {})
	end

	def add_comment
		comment = Comment.new
		comment.content = post_params[:content]
		comment.user = User.find(post_params[:user_id])
		comment.post = Post.find(post_params[:id])
		comment.save

		render json: comment.to_json(include: {
			user: {
				only: [:id, :name, :username]
			},
			post: {
				only: [:id]
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

		params.require(:post).permit(:id, :content, :title, :user_id, :username, categories: [], )

	end

end