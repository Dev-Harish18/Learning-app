class Api::V1::AttemptSerializer < ActiveModel::Serializer
  attributes :id,:user_id,:exercise_id,:time_spent,:total_score,:attempted_questions

  def attempted_questions
    @instance_options[:questions].map.with_index do |ques,i|
      {
          id:ques.id,
          question:ques.name,
          correct_option:ques.correct_option,
          option1:ques.option1,
          option2:ques.option2,
          option3:ques.option3,
          submitted_answer:@instance_options[:records][i][:submitted_answer],
          score:@instance_options[:records][i][:score]
      }
    end
  end

end
