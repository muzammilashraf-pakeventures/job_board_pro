FactoryBot.define do
  factory :application do
    user { nil }
    job { nil }
    status { "MyString" }
    resume { "MyString" }
    cover_letter { "MyText" }
  end
end
