class CategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :search_term
  has_many :posts
end
