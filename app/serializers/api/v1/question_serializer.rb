class Api::V1::QuestionSerializer < ActiveModel::Serializer
  attributes :id,:exercise_id,:name,:option1,:option2,:option3,:correct_option

end
