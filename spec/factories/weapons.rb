FactoryBot.define do
  factory :weapon do
    name { Faker::Games::LeagueOfLegends.champion }
    description { Faker::Games::LeagueOfLegends.quote }
    power_base { rand(3000..10_000) }
    power_step { rand(99..1000) }
    level { rand(1..99) }
  end
end
