require 'rails_helper'

RSpec.describe 'Road Trip Endpoints' do
  describe 'Create a new Road Trip (/api/v0/road_trip)' do
    it 'retrieves travel time and weather at eta for a given road trip', :vcr do
      user = create(:user)
  
      road_trip = {
        "origin": "Cincinatti,OH",
        "destination": "Chicago,IL",
        "api_key": user.api_key
      }
      post '/api/v0/road_trip', params: road_trip.to_json, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' } 

      expect(request.url).to eq("http://www.example.com/api/v0/road_trip")
      expect(response).to be_successful
      expect(response.status).to eq(200)

      road_trip = JSON.parse(response.body, symbolize_names: true)
      expect(road_trip).to have_key(:data)
      expect(road_trip[:data]).to have_key(:attributes)
      expect(road_trip[:data][:attributes]).to have_key(:start_city)
      expect(road_trip[:data][:attributes][:start_city]).to eq("Cincinatti,OH")
      expect(road_trip[:data][:attributes]).to have_key(:end_city)
      expect(road_trip[:data][:attributes][:end_city]).to eq("Chicago,IL")
      expect(road_trip[:data][:attributes]).to have_key(:travel_time)
      expect(road_trip[:data][:attributes][:travel_time]).to eq("04:20:56")
      expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)
      expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:datetime)
      expect(road_trip[:data][:attributes][:weather_at_eta][:datetime]).to be_a(String)
      expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
      expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:condition)
      expect(road_trip[:data][:attributes][:weather_at_eta][:condition]).to be_a(String)
    end
  end
end 