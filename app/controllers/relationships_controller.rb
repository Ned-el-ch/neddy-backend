class RelationshipsController < ApplicationController

	skip_before_action :authorized#, only: [:followers, :followed]

	def followers
		user = User.find_by(username: params[:username])
		followers = user.passive_relationships
		if user
			render json: followers.to_json(include: {
				follower_user: {
					only: [:id, :username, :name]
				}
			},
			only: [])
		else
			render json: {message: "oopsie"}
		end
	end

	def followed
		user = User.find_by(username: params[:username])
		following = user.active_relationships
		if user
			render json: following.to_json(include: {
				followed_user: {
					only: [:id, :username, :name]
				}
			},
			only: [])
		else
			render json: {message: "oopsie"}
		end
	end

	def create
		follower = User.find_by(username: relationship_params[:follower_username])
		followed = User.find_by(username: relationship_params[:followed_username])
		# byebug
		if follower && followed
			relation_exists = Relationship.where(follower_user: follower, followed_user: followed).first
			if relation_exists
				render json: {message: "already following"}
			else
				Relationship.create(follower_user: follower, followed_user: followed)
				render json: {response: true}
			end
		else
			render json: {message: "one of those usernames aint real (trying to follow)"}
		end
	end

	def destroy
		follower = User.find_by(username: relationship_params[:follower_username])
		followed = User.find_by(username: relationship_params[:followed_username])
		if follower && followed
			relation_exists = Relationship.where(follower_user: follower, followed_user: followed).first
			if relation_exists
				relation_exists.destroy
				render json: {response: false}
			else
				render json: {message: "you weren't following in the first place"}
			end
		else
			render json: {message: "one of those usernames aint real (trying to unfollow)"}
		end
	end

	private

	def relationship_params
		params.require(:relationship).permit(:follower_username, :followed_username)
	end

end