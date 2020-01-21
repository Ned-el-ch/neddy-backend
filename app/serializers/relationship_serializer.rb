class RelationshipSerializer < ActiveModel::Serializer
  attributes :id
  has_one :follower_user
  has_one :followed_user
end
