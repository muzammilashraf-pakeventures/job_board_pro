FactoryBot.define do
  factory :company do
    name { "MyString" }
    description { "MyText" }
    website { "MyString" }
    location { "MyString" }
    account { nil }
    user { nil }
  end
end
