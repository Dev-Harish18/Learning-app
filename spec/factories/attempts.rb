FactoryBot.define do
  factory :attempt do
    sequence(:id) {|n| n}
    time_spent { 1 }
    total_score { 1 }
    user_id {1}
    exercise_id {1}
  end
end
