FactoryBot.define do
  factory :user do
    sequence(:email)  { |n| "#{n}#{FFaker::Internet.email}" }
    password 'abc12345'
  end
end
