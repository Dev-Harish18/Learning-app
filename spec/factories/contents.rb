FactoryBot.define do
  factory :content do
    sequence(:id) {|n| n}
    title { "MyString" }
    file_type { "pdf" }
    path { "/fils/pdf/sample.pdf" }
    description { "Sample description" }
    sequence(:chapter_id) {|n| n}
  end
end
