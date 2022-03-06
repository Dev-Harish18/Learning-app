FactoryBot.define do
  factory :user_content do
    notes { "MyString" }
    upvoted { true }
    downvoted { false }
    user_id { 1 }
    content_id { 1 }
  end
end
