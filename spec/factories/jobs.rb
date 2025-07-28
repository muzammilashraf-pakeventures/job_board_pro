FactoryBot.define do
  factory :job do
    title { "MyString" }
    description { "MyText" }
    requirements { "MyText" }
    salary_range { "MyString" }
    location { "MyString" }
    job_type { "MyString" }
    status { "MyString" }
    account { nil }
    company { nil }
    user { nil }
  end
end
