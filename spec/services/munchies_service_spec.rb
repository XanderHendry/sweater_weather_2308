require 'rails_helper' 

RSpec.describe MunchiesService do 
  context "class methods" do
    context '#restaurant_rec', :vcr do
      it 'returns weather info in the area of the given lat+lon', :vcr do 
        forecast = MunchiesService.restaurant_rec('Denver, CO', 'Pizza')
        expect(forecast[:businesses].first[:name]).to eq("Brooklyn's Finest Pizza")
      end
    end
    context "#get_url" do
      it "returns parsed JSON data", :vcr do 
        parsed_response = MunchiesService.get_url("/v3/businesses/search?location=denver%2Cco&term=italian&sort_by=best_match&limit=20")
        expect(parsed_response).to be_a Hash
        expect(parsed_response[:businesses]).to be_an(Array)
        expect(parsed_response[:businesses].first).to be_a(Hash)
      end
    end
    context "#conn" do
      it "returns Faraday object", :vcr do
        expect(MunchiesService.conn).to be_a(Faraday::Connection)      
      end
    end
  end
end