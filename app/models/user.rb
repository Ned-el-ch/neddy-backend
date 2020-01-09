class User < ApplicationRecord
	has_secure_password
	validates :username, uniqueness: { case_sensitive: false }
	has_many :posts
	has_many :comments
	has_many :post_likes
	has_many :post_favorites
end
