require 'rails_helper' 

RSpec.describe WeatherService do 
  context "class methods" do
    context '#weather_at_location', :vcr do
      it 'returns weather info in the area of the given lat+lon', :vcr do 
        forecast = WeatherService.forecast_at_location({lat: '33.95', lon: '-81.12'}, 5)
        expect(forecast[:location][:region]).to eq("South Carolina")
        expect(forecast[:current]).to be_a(Hash)
        expect(forecast[:forecast][:forecastday]).to be_an(Array)
        expect(forecast[:forecast][:forecastday].count).to eq(5)
      end
    end
    context '#weather_at_eta', :vcr do
    it 'returns a forecast for a specified destination and date' do
      forecast = WeatherService.forecast_at_location({lat: '33.95', lon: '-81.12'}, Date.tomorrow)
      expect(forecast[:location][:region]).to eq("South Carolina")
        expect(forecast[:current]).to be_a(Hash)
        expect(forecast[:forecast][:forecastday]).to be_an(Array)
        expect(forecast[:forecast][:forecastday].count).to eq(1)
    end
  end
    context "#get_url" do
      it "returns parsed JSON data", :vcr do 
        parsed_response = WeatherService.get_url("/v1/forecast.json?q=33.95,-81.12")
        expect(parsed_response).to be_a Hash
        expect(parsed_response[:location]).to be_a(Hash)
        expect(parsed_response[:forecast]).to be_a(Hash)
      end
    end
    context "#conn" do
      it "returns Faraday object", :vcr do
        expect(WeatherService.conn).to be_a(Faraday::Connection)      
      end
    end
  end
end