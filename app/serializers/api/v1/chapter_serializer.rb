class Api::V1::ChapterSerializer < ActiveModel::Serializer
  attributes :id,:name,:subject_id,:exercises

  def exercises

    object.exercises.map do |i|
      {
        id:i.id,
        name:i.name,
        duration:i.duration
      }
    end
  end
end
