FactoryBot.define do
  factory :question do
    sequence(:id) {|n| n}
    sequence(:name) {|n| "What is #{n}"}
    correct_option { "correct option" }
    option1 { "Option 1" }
    option2 { "Option 2" }
    option3 { "Option 3" }
    sequence(:exercise_id) { |n| n }
  end
end
