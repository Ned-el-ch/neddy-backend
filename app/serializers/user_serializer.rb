class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :avatar, :bio
  has_many :posts
end
