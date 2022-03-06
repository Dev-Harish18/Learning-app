class Api::V1::ExerciseSerializer < ActiveModel::Serializer
  attributes :id,:name,:duration,:chapter_id,:questions

  def questions
    object.questions.map do |ques|
      {
      id:ques.id,
      question:ques.name,
      correct_option:ques.correct_option,
      option1:ques.option1,
      option2:ques.option2,
      option3:ques.option3
      }    
    end
  end

end
