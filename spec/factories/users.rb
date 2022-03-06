FactoryBot.define do
  factory :user do
    sequence(:id) {|n| n}
    name { "Harish" }
    mobile { "9087654333" }
    email { "abcd@gmail.com" }
    dob { "2001-03-01" }
    password_digest {"MyString"}
    sequence(:board_id) { |n| n }
    sequence(:grade_id) { |n| n }
  end
end
