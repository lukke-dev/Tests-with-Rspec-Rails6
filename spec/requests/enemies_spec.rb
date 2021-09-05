require 'rails_helper'

RSpec.describe 'Enemies', type: :request do
  describe 'GET /index' do
    it 'should display the name\'s correctly' do
      enemy = build(:enemy, name: 'inimigo')
      enemy.save
      get enemies_path
      expect(response.body).to include('inimigo')
    end

    it 'should display the power_base correctly' do
      enemy = build(:enemy, power_base: 3157)
      enemy.save
      get enemies_path
      expect(response.body).to include('3157')
    end

    it 'returns success status' do
      get enemies_path
      expect(response).to have_http_status(200)
    end

    describe 'GET show' do
      it 'should display the name\'s correctly' do
        enemy = build(:enemy, name: 'inimigo')
        enemy.save
        get "/enemies/#{enemy.id}"
        expect(response.body).to include('inimigo')
      end

      it 'should display the power_base correctly' do
        enemy = build(:enemy, power_base: 3157)
        enemy.save
        get "/enemies/#{enemy.id}"
        expect(response.body).to include('3157')
      end

      it 'returns failure status' do
        get '/enemies/0'
        expect(response).to have_http_status(404)
      end
    end

    describe 'POST create' do
      context 'when it has valid attributes' do
        it 'creates the enemy with correct params' do
          attributes = attributes_for(:enemy)
          expect do
            post '/enemies', params: attributes
          end.to change(Enemy, :count)
        end
      end

      context 'when it has no valid parameters' do
        it 'does not create enemy' do
          enemy = build(:enemy)
          expect { enemy.reload }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
    describe 'GET /enemies' do
      context 'when the enemy exists' do
        let(:enemy) { create(:enemy) }
        let(:attributes) { attributes_for(:enemy) }

        before(:each) { put "/enemies/#{enemy.id}", params: attributes }

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
        it 'updates the enemy' do
          expect(enemy.reload).to have_attributes(attributes)
        end

        it 'returns the enemy updated' do
          expect(enemy.reload).to have_attributes(json.except('created_at', 'updated_at'))
        end
      end

      context 'when the enemy does not exist' do
        before(:each) { put '/enemies/0', params: attributes_for(:enemy) }

        it 'return status code 404' do
          expect(response).to have_http_status(404)
        end
        it 'returns a not found message' do
          expect(response.body).to include('Couldn\'t find Enemy')
        end
      end
    end

    describe 'DELETE /enemies' do
      context 'when the enemy exists' do
        let(:enemy) { create(:enemy) }
        before(:each) { delete "/enemies/#{enemy.id}" }

        it 'returns status code 200' do
          expect(response).to have_http_status(204)
        end

        it 'destroy the record' do
          expect { enemy.reload }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context 'when the enemy does not exist' do
        before(:each) { delete '/enemies/0' }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a not found message' do
          expect(response.body).to include('Couldn\'t find Enemy')
        end
      end
    end
  end
end
