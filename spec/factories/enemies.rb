FactoryBot.define do
  factory :enemy do
    name { Faker::Games::LeagueOfLegends.champion }
    power_base { rand(3000..10_000) }
    power_step { rand(99..1000) }
    level { rand(1..99) }
    kind { %w[goblin orc demon dragon].sample }
  end
end
