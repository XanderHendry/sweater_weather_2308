require 'rails_helper'

RSpec.describe RoadTrip do
  it 'can initialize' do
    roadtrip = RoadTrip.new({start_city: "Cincinatti, OH",
    end_city: "Chicago, IL",
    travel_time: "04:40:45",
    weather_at_eta: {
        datetime: "2023-04-07 23:00",
        temperature: 44.2,
        condition: "Cloudy with a chance of meatballs"
    }})

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