FactoryBot.define do
  factory :user do
    nickname { Faker::Lorem.word }
    level { rand(1..99) }
    kind { %w[knight wizard].sample }
  end
end
