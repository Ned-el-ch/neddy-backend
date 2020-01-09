class Post < ApplicationRecord
	belongs_to :user
	has_many :post_likes
	has_many :post_favorites
	has_many :post_categories
	has_many :comments
	has_many :categories, through: :post_categories
end