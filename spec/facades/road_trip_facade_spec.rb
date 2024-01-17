require 'rails_helper'

RSpec.describe RoadTripFacade do
  describe 'Class Methods' do
    describe '#get_location_data' do
      it 'makes external api calls and creates a poro with travel time and weather at the ETA', :vcr  do
        road_trip = RoadTripFacade.plan_roadtrip({origin: "Cincinatti,OH", destination: "Chicago,IL"})
        expect(road_trip).to be_a(RoadTrip)
        expect(road_trip.id).to eq(nil)
        expect(road_trip.start_city).to eq("Cincinatti,OH")
        expect(road_trip.end_city).to eq("Chicago,IL")
        expect(road_trip.travel_time).to eq("04:20:56")
        expect(road_trip.weather_at_eta).to be_a(Hash)
        expect(road_trip.weather_at_eta).to have_key(:datetime)
        expect(road_trip.weather_at_eta).to have_key(:temperature)
        expect(road_trip.weather_at_eta).to have_key(:condition)
      end
    end
  end
end 