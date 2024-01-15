require 'rails_helper'

RSpec.describe MunchiesSerializer do
  it 'serialized a response using data from the WeatherService, and MunchiesService', :vcr do

    forecast = WeatherService.forecast_at_location({lat: '33.95', lon: '-81.12'}, 3)
    restaurant = MunchiesService.restaurant_rec('Columbia, SC', 'Pizza')
    response = MunchiesSerializer.new(forecast, restaurant)
    output = response.serialize_json
    expect(output).to have_key(:data)
    expect(output[:data]).to be_an(Hash)
    
    data = output[:data]
    expect(data).to have_key(:id)
    expect(data[:id]).to be_nil
    expect(data).to have_key(:type)
    expect(data[:type]).to eq('munchie')
    expect(data).to have_key(:attributes)
    attributes = data[:attributes]
    expect(attributes).to have_key(:destination_city)
    expect(attributes[:destination_city]).to be_a(String)
    expect(attributes).to have_key(:forecast)
    expect(attributes[:forecast]).to be_a(Hash)
    expect(attributes[:forecast]).to have_key(:summary)
    expect(attributes[:forecast][:summary]).to be_a(String)
    expect(attributes[:forecast]).to have_key(:temperature)
    expect(attributes[:forecast][:temperature]).to be_a(String)
    expect(attributes).to have_key(:restaurant)
    expect(attributes[:restaurant]).to be_a(Hash)
    expect(attributes[:restaurant]).to have_key(:name)
    expect(attributes[:restaurant][:name]).to be_a(String)
    expect(attributes[:restaurant]).to have_key(:address)
    expect(attributes[:restaurant][:address]).to be_a(String)
    expect(attributes[:restaurant]).to have_key(:rating)
    expect(attributes[:restaurant][:rating]).to be_a(Float)
    expect(attributes[:restaurant]).to have_key(:reviews)
    expect(attributes[:restaurant][:reviews]).to be_a(Integer)
  end
end