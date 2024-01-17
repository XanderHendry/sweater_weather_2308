require 'rails_helper'

RSpec.describe 'Road Trip Endpoints' do
  describe 'Register as a new User' do
    describe 'POST /api/v0/road_trip' do
      before(:each) do
        @user = create(:user)
      end
      describe 'Happy Path' do
        it 'returns travel time, and weather conditions for a requested road trip', vcr: { :match_requests_on => [:method, VCR.request_matchers.uri_without_param(:dt)] }do
          road_trip = {
            "origin": "NewYork,NY",
            "destination": "LosAngeles,CA",
            "api_key": @user.api_key
          }
          post '/api/v0/road_trip', params: road_trip.to_json, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }
          expect(request.url).to eq("http://www.example.com/api/v0/road_trip")
          expect(response.status).to eq(200)
          expect(response).to have_http_status(:ok)
          results = JSON.parse(response.body, symbolize_names: true)
          expect(results[:data][:type]).to eq("road_trip")
          expect(results[:data][:attributes][:start_city]).to eq("NewYork,NY")
          expect(results[:data][:attributes][:end_city]).to eq("LosAngeles,CA")
          expect(results[:data][:attributes][:travel_time]).to eq("38:51:52")
          expect(results[:data][:attributes][:weather_at_eta]).to be_a(Hash)
          expect(results[:data][:attributes][:weather_at_eta][:datetime]).to be_a(String)
          expect(results[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
          expect(results[:data][:attributes][:weather_at_eta][:condition]).to be_a(String)
        end
      end  
      describe 'Sad Path' do
        it 'returns a travel time of "impossible" and an empty weather block if a trip can not be completed', :vcr do
          road_trip = {
            "origin": "NewYork,NY",
            "destination": "London,UK",
            "api_key": @user.api_key
          }
          
          post '/api/v0/road_trip', params: road_trip.to_json, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' } 
          
          expect(response.status).to eq(200)
          expect(response).to have_http_status(:ok)
          results = JSON.parse(response.body, symbolize_names: true)
          expect(results[:data][:type]).to eq("road_trip")
          expect(results[:data][:attributes][:start_city]).to eq("NewYork,NY")
          expect(results[:data][:attributes][:end_city]).to eq("London,UK")
          expect(results[:data][:attributes][:travel_time]).to eq("Impossible")
          expect(results[:data][:attributes][:weather_at_eta]).to be_a(Hash)
          expect(results[:data][:attributes][:weather_at_eta].keys).to eq([])
        end

        it 'returns an error if a request is made using an invalid api_key', :vcr do
          road_trip = {
            "origin": "NewYork,NY",
            "destination": "LosAngeles,CA",
            "api_key": "invalid API key"
          }
          
          post '/api/v0/road_trip', params: road_trip.to_json, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' } 
          
          expect(response.status).to eq(401)
          expect(response).to have_http_status(:unauthorized)
          results = JSON.parse(response.body, symbolize_names: true)
          expect(results[:errors]).to eq(["Unauthorized API Key"])
        end
      end
    end
  end
end