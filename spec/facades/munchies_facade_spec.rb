require 'rails_helper'

RSpec.describe MunchiesFacade do
  describe 'Instance Methods' do
    describe '#initialize' do
      it 'initialized with location and food attributes' do
        facade = MunchiesFacade.new('Denver, CO', 'Pizza')
        expect(facade.location).to eq('Denver, CO')
        expect(facade.food).to eq('Pizza')
      end
    end
    describe '#weather_data' do
      it 'makes external api calls and returns current weather for the facades location' do
        facade = MunchiesFacade.new('Denver, CO', 'Pizza')
        weather = facade.weather_data
        expect(weather).to have_key(:locations)
        expect(weather[:locations]).to have_key(:current_weather)
      end
    end
    describe '#restaurant_rec' do
      it 'makes an external api call and returns the highest rated restaurant in the area for the facades location and food type' do
        facade = MunchiesFacade.new('Denver, CO', 'Pizza')
        restaurant = facade.restaurant_rec
        expect(restaurant[:businesses].first[:name]).to eq("Brooklyn's Finest Pizza")
      end
    end
    describe '#restaurant_rec_and_weather' do
      it 'uses the restaurant_rec and weather data methods to assemble data, and then passes it to the munchies serializer', :vcr do
        facade = MunchiesFacade.new('Denver, CO', 'Pizza')
        response = facade.restaurant_rec_and_weather
        expect(response).to be_a(Hash)
        expect(response).to have_key([:data])
        expect(response).to have_key([:id])
        expect(response).to have_key([:type])
        expect(response).to have_key([:attributes])
        expect(response).to have_key([:attributes][:forecast])
        expect(response).to have_key([:attributes][:restaruant])
      end
    end
  end
end 