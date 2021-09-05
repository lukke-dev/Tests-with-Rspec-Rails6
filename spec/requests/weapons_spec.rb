require 'rails_helper'

RSpec.describe 'Weapons', type: :request do
  describe 'GET /show' do
    it 'show attributes' do
      attributes = FactoryBot.attributes_for(:weapon, name: 'textweapon', description: 'descweapon')
      post(weapons_path, params: { weapon: attributes })
      get weapon_path(Weapon.last)
      expect(response.body).to include('textweapon', 'descweapon')
    end
  end

  describe 'DELETE /destroy' do
    it 'delete weapon' do
      weap = build(:weapon)
      weap.save
      expect do
        delete "/weapons/#{weap.id}"
      end.to change(Weapon, :count)
    end
  end

  describe 'GET /index' do
    it 'should display the names correctly' do
      name = Faker::Name.first_name
      weap = build(:weapon, name: name)
      weap.save
      get weapons_path
      expect(response.body).to include(name)
    end

    it 'should display the current_power correctly' do
      weap = build(:weapon, power_base: 3000, level: 1)
      weap.save
      get weapons_path
      expect(response.body).to include('3000')
    end

    it 'should display the titles correctly' do
      weap = build(:weapon, name: 'excalibur', level: 1)
      weap.save
      get weapons_path
      expect(response.body).to include('excalibur #1')
    end
  end

  describe 'POST /create' do
    it 'correct parameters create' do
      attributes = FactoryBot.attributes_for(:weapon)
      expect do
        post(weapons_path, params: { weapon: attributes })
      end.to change(Weapon, :count)
    end
    it 'invalid parameters does not create' do
      attributes = FactoryBot.attributes_for(:weapon, name: '12')
      expect do
        post(weapons_path, params: { weapon: attributes })
      end.to_not change(Weapon, :count)
    end
  end
end

RSpec.describe 'Weapons', type: :routing do
  it 'should display the links correctly' do
    weap = build(:weapon)
    weap.save
    expect(get: weapons_path).to route_to("controller": 'weapons', "action": 'index')
  end
end
