require 'rails_helper'

RSpec.describe RoadTripFacade do
  describe 'Class Methods' do
    describe '#get_location_data' do
      it 'makes external api calls and creates a poro with travel time and weather at the ETA', :vcr do
        roadtrip = RoadTripFacade.plan_roadtrip({origin: "Cincinatti,OH", destination: "Chicago,IL"})
        binding.pry
        expect(roadtrip).to be_a(RoadTrip)
        expect(roadtrip.id).to eq(nil)
        expect(roadtrip.start_city).to eq("Cincinatti, OH")
        expect(roadtrip.end_city).to eq("Chicago, IL")
        expect(roadtrip.travel_time).to eq("04:40:45")
        expect(roadtrip.weather_at_eta).to be_a(Hash)
        expect(roadtrip.weather_at_eta[:datetime]).to eq("2023-04-07 23:00")
        expect(roadtrip.weather_at_eta[:temperature]).to eq(44.2)
        expect(roadtrip.weather_at_eta[:condition]).to eq("Cloudy with a chance of meatballs")
      end
    end
  end
end 