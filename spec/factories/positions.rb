FactoryBot.define do
  factory :position do
    title { FFaker::Job.title }
    description "MyText"
  end
end
