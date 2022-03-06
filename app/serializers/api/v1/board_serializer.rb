class Api::V1::BoardSerializer < ActiveModel::Serializer
  attributes :id,:name,:grades

  def grades
    
    object.grades.map do |grade|
      {
      id: grade.id,
      standard: grade.standard,
      }
    end

  end
end
