FactoryBot.define do
  factory :chapter do
    sequence(:id) {|n| n}
    sequence(:name) {|n| "Chapter-#{n}"}
    sequence(:subject_id) {|n| n}
  end
end
