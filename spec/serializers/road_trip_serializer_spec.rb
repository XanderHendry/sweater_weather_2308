require 'rails_helper'

RSpec.describe RoadTripSerializer do
  it 'formats data from the RoadtripFacade', :vcr do
    roadtrip = RoadTrip.new({start_city: "Cincinatti, OH",
    end_city: "Chicago, IL",
    travel_time: "04:40:45",
    weather_at_eta: {
        datetime: "2023-04-07 23:00",
        temperature: 44.2,
        condition: "Cloudy with a chance of meatballs"
    }})
    output = RoadTripSerializer.new(roadtrip).serialize_json
    expect(output).to have_key(:data)
    expect(output[:data]).to be_an(Hash)
    expect(output[:data]).to have_key(:id)
    expect(output[:data][:id]).to eq('Null')
    expect(output[:data]).to have_key(:type)
    expect(output[:data][:type]).to eq("road_trip")
    expect(output[:data]).to have_key(:attributes)
    expect(output[:data][:attributes]).to be_a(Hash)
    expect(output[:data][:attributes]).to have_key(:start_city)
    expect(output[:data][:attributes][:start_city]).to be_a(String)
    expect(output[:data][:attributes]).to have_key(:end_city)
    expect(output[:data][:attributes][:end_city]).to be_a(String)
    expect(output[:data][:attributes]).to have_key(:travel_time)
    expect(output[:data][:attributes][:travel_time]).to be_a(String)
    expect(output[:data][:attributes]).to have_key(:weather_at_eta)
    expect(output[:data][:attributes][:weather_at_eta]).to be_a(Hash)
    expect(output[:data][:attributes][:weather_at_eta]).to have_key(:datetime)
    expect(output[:data][:attributes][:weather_at_eta][:datetime]).to be_a(String)
    expect(output[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
    expect(output[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
    expect(output[:data][:attributes][:weather_at_eta]).to have_key(:condition)
    expect(output[:data][:attributes][:weather_at_eta][:condition]).to be_a(String)
  end
end