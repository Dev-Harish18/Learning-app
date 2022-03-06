FactoryBot.define do
  factory :exercise do
    sequence(:id) {|n| n}
    sequence(:name) {|n| "exercise-#{n}"}
    sequence(:duration) {|n| "#{n} minutes"}
    sequence(:chapter_id) { |n| n }
  end
end
