class PostSerializer < ActiveModel::Serializer
  attributes :id, :content
  has_one :user
  has_many :post_categories
  has_many :post_likes
  has_many :post_favorites
  has_many :comments
end
