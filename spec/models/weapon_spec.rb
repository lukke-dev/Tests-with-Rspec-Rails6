require 'rails_helper'

RSpec.describe Weapon, type: :model do
  it 'the title is correct' do
    weapon = build(:weapon, name: 'excalibur', level: 3)
    expect(weapon.title).to eq('excalibur #3')
  end

  it 'the current_power is correct' do
    weapon = build(:weapon, power_base: 3000, power_step: 100, level: 10)
    expect(weapon.current_power).to eq(3900)
  end
end
