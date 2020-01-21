class User < ApplicationRecord
	has_secure_password
	validates :username, uniqueness: { case_sensitive: false }
	has_many :user_categories
	has_many :categories, through: :user_categories
	has_many :posts
	has_many :comments
	has_many :post_likes
	has_many :post_favorites
	has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
	has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
	has_many :followed_users, through: :active_relationships, source: :followed_user
	has_many :follower_users, through: :passive_relationships, source: :follower_user
end