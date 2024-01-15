require 'rails_helper'

RSpec.describe 'Munchies Endpoints' do
  describe 'Retrieve Weather for a city (/api/v0/vendors/forecast?location=query)' do
    it 'retrieveretrieve variable food and forecast information for a destination city.', :vcr do
      get '/api/v/forecast?location=cincinatti,oh'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      munchie = JSON.parse(response.body, symbolize_names: true)

      expect(munchie).to have_key(:data)
      expect(munchie[:data]).to have_key(:attributes)
      expect(munchie[:data][:attributes]).to have_key(:destination_city)
      expect(munchie[:data][:attributes][:destination_city]).to be_an(String)
      expect(munchie[:data][:attributes]).to have_key(:forecast)
      expect(munchie[:data][:attributes][:forecast]).to be_a(Hash)
      expect(munchie[:data][:attributes]).to have_key(:daily_weather)
      expect(munchie[:data][:attributes][:restaurant]).to be_an(Hash)
    end
  end
end 