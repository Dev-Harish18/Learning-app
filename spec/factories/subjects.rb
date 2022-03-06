FactoryBot.define do
  factory :subject do
    sequence(:id) {|n| n}
    sequence(:name) {|n| "Subject-#{n}"}
    sequence(:grade_id) {|n| n}
  end
end
