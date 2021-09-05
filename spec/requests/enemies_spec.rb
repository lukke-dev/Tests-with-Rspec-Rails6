require 'rails_helper'

RSpec.describe 'Enemies', type: :request do
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
