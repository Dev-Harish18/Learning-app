class Api::V1::GradeSerializer < ActiveModel::Serializer
  attributes :id,:standard,:board_id,:subjects

  def subjects
    object.subjects.map do |sub|
        {
          id:sub.id,
          name:sub.name
        }
    end
  end
end
