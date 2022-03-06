FactoryBot.define do
  factory :board do
    sequence(:id) {|n| n}
    sequence(:name) {|n| "CBSE#{n}"}
  end
end
