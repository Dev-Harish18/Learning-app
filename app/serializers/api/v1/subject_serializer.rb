class Api::V1::SubjectSerializer < ActiveModel::Serializer
  attributes :id,:name,:grade_id,:chapters

  def chapters
    object.chapters.map do |chapter|
      {
        id:chapter.id,
        name:chapter.name
      }
    end
  end
end
