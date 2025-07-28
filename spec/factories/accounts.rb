FactoryBot.define do
  factory :account do
    name { "MyString" }
    slug { "MyString" }
    subdomain { "MyString" }
    active { false }
    settings { "" }
  end
end
