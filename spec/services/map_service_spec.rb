require 'rails_helper' 

RSpec.describe MapService do 
  context "class methods" do
    context '#get_location_data' do
      it 'it returns information for the given location, including lat+lon', :vcr do 
        location = MapService.get_location_data("Columbia,SC")
        expect(location[:results].first[:locations].first[:latLng]).to be_a(Hash)
        expect(location[:results].first[:locations].first[:latLng][:lat]).to eq(33.99882)
        expect(location[:results].first[:locations].first[:latLng][:lng]).to eq(-81.04537)
      end
    end
    context '#get_directions', :vcr do
      it 'gets directions from a provided origin and destination' do
        directions = MapService.get_directions("Cincinatti,OH", "Chicago,IL")
        expect(directions[:route]).to be_a(Hash)
        expect(directions[:route][:formattedTime]).to eq("04:20:56")
        expect(directions[:route][:locations].last[:adminArea5]).to eq("Chicago")
      end
    end
    context "#get_url", :vcr do
      it "returns parsed JSON data" do 
        parsed_response = MapService.get_url("/geocoding/v1/address?location=Columbia,SC")
        expect(parsed_response).to be_a Hash
        expect(parsed_response[:results]).to be_an(Array)
      end
    end
    context "#conn", :vcr do
      it "returns Faraday object" do
        expect(MapService.conn).to be_a(Faraday::Connection)      
      end
    end
  end
end