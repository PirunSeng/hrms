FactoryBot.define do
  factory :user do
    address { FFaker::Address.city }
    sequence(:email)  { |n| "#{n}#{FFaker::Internet.email}" }
    name { FFaker::Name.name }
    password 'abc12345'
    phone { FFaker::PhoneNumber.short_phone_number }
    salary 300
    start_date { FFaker::Time.date }

    association :department, factory: :department
    association :position, factory: :position
  end
end
