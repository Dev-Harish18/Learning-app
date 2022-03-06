class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id,:name,:mobile,:email,:auth_token,:created_at,:dob,:board_id,:grade_id

  def auth_token
    return @instance_options[:token]
  end
end
