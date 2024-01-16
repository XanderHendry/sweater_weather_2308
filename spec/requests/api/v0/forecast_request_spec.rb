require 'rails_helper'

RSpec.describe 'Forecast Endpoints' do
  describe 'Retrieve Weather for a city (/api/v0/vendors/forecast?location=query)' do
    it 'retrieves a 5 day forecast for the given city', :vcr do
      get '/api/v0/forecast?location=cincinatti,oh'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(forecast).to have_key(:data)
      expect(forecast[:data]).to have_key(:attributes)
      expect(forecast[:data][:attributes]).to have_key(:current_weather)
      expect(forecast[:data][:attributes][:current_weather]).to be_a(Hash)
      expect(forecast[:data][:attributes]).to have_key(:daily_weather)
      expect(forecast[:data][:attributes][:daily_weather]).to be_an(Array)
      expect(forecast[:data][:attributes]).to have_key(:hourly_weather)
      expect(forecast[:data][:attributes][:hourly_weather]).to be_an(Array)
    end
  end
end 
