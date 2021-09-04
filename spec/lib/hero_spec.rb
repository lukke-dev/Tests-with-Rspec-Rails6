require 'spec_helper'
require 'hero'

describe Hero do
  it 'has a sword' do
    hero = Hero.new
    expect(hero.weapon).to eq('sword')
  end

  it 'has more than 1000 hp points' do
    hero = Hero.new
    expect(hero.hp).to be > 1000
    expect([hero.hp]).to all(be > 1000)
    # obj = 'ola'
    # expect(obj).to be_a(String)
  end
end
