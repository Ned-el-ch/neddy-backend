class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :avatar, :bio
  has_many :posts
  has_many :passive_relationships
  has_many :active_relationships
end
