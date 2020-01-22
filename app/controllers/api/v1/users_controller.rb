class Api::V1::UsersController < ApplicationController
	skip_before_action :authorized, only: [:create, :posts]

	def profile
		# byebug
		# render json: { user: UserSerializer.new(current_user) }, status: :accepted
		render json: current_user.to_json(only: [:id, :name, :username, :bio]), status: :accepted

	end

	def posts
		user = User.all.find_by(username: params[:username])
		render json: user.to_json(
			include: {
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
				active_relationships: {
					include: {
						followed_user: {
							only: [:username, :name]
						}
					}, only: []
				},
				passive_relationships: {
					include: {
						follower_user: {
							only: [:username, :name]
						}
					}, only: []
				},
				categories: {
					only: [:id, :title]
				}
			}, only: [:username, :name, :bio]
		)
	end

	def create

		@user = User.create(user_params)

		if @user.valid?

			@token = encode_token({ user_id: @user.id })
			render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created

		else

			render json: { error: 'failed to create user' }, status: :not_acceptable

		end

	end

	private

	def user_params

		params.require(:user).permit(:username, :name, :password, :bio, :avatar)

	end

end