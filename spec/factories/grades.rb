FactoryBot.define do
  factory :grade do
    sequence(:id) {|n| n}
    sequence(:standard) {|n| n}
    sequence(:board_id) {|n| n}
  end
end
