class PostCategorySerializer < ActiveModel::Serializer
  attributes :id
  has_one :post
  has_one :category
end
