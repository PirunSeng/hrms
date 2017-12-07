FactoryBot.define do
  factory :department do
    name { FFaker::Name.name }
    description { FFaker::Lorem.paragraph }
  end
end
