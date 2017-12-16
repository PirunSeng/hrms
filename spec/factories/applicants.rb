FactoryBot.define do
  factory :applicant do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
    phone { FFaker::PhoneNumber.short_phone_number }
    interview_date { FFaker::Time.datetime }
  end
end
