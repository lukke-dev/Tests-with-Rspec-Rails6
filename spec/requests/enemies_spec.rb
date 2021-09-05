require 'rails_helper'

RSpec.describe 'Enemies', type: :request do
  describe 'GET /enemies' do
    context 'when the enemy exists' do
      it 'returns status code 200' do
        enemy = create(:enemy)
        attributes = attributes_for(:enemy)
        put "/enemies/#{enemy.id}", params: attributes
        expect(response).to have_http_status(200)
      end
      it 'updates the enemy' do
        enemy = create(:enemy)
        attributes = attributes_for(:enemy)
        put "/enemies/#{enemy.id}", params: attributes

        expect(enemy.reload).to have_attributes(attributes)
      end

      it 'returns the enemy updated' do
        enemy = create(:enemy)
        attributes = attributes_for(:enemy)
        put "/enemies/#{enemy.id}", params: attributes

        json_resp = JSON.parse(response.body)
        expect(enemy.reload).to have_attributes(json_resp.except('created_at', 'updated_at'))
      end
    end

    context 'when the enemy does not exist' do
      it 'return status code 404' do
        attributes = attributes_for(:enemy)
        put '/enemies/1', params: attributes
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        attributes = attributes_for(:enemy)
        put '/enemies/1', params: attributes
        expect(response.body).to include('Couldn\'t find Enemy')
      end
    end
  end

  describe 'DELETE /enemies' do
    context 'when the enemy exists' do
      it 'returns status code 200' do
        enemy = create(:enemy)
        delete "/enemies/#{enemy.id}"
        expect(response).to have_http_status(204)
      end

      it 'destroy the record' do
        enemy = create(:enemy)
        delete "/enemies/#{enemy.id}"
        expect { enemy.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when the enemy does not exist' do
      it 'returns status code 404' do
        delete '/enemies/0'
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        delete '/enemies/0'
        expect(response.body).to include('Couldn\'t find Enemy')
      end
    end
  end
end
