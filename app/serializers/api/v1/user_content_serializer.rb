class Api::V1::UserContentSerializer < ActiveModel::Serializer
  attributes :id,:upvoted,:downvoted,:notes
  # belongs_to :content
end
