FactoryBot.define do
  factory :attempted_question do
    submitted_answer { "MyString" }
    score { 1 }
    sequence(:attempt_id) {|n| n}
    sequence(:question_id) {|n| n}
  end
end
