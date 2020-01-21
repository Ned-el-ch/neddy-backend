class Category < ApplicationRecord
	has_many :post_categories
	has_many :posts, through: :post_categories
	has_many :user_categories
	has_many :users, through: :user_categories
end