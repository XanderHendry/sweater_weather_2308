require 'rails_helper'

RSpec.describe 'Munchies Endpoints' do
  describe 'Retrieve Weather for a city (/api/v0/vendors/forecast?location=query)' do
    it 'retrieveretrieve variable food and forecast information for a destination city.', :vcr do
      get '/api/v1/munchies?destination=pueblo,co&food=italian'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      munchie = JSON.parse(response.body, symbolize_names: true)
      expect(munchie).to have_key(:data)
      expect(munchie[:data]).to have_key(:id)
      expect(munchie[:data][:id]).to eq(nil)
      expect(munchie[:data]).to have_key(:type)
      expect(munchie[:data][:type]).to eq('munchie')
      expect(munchie[:data]).to have_key(:attributes)
      expect(munchie[:data][:attributes]).to be_a(Hash)
      expect(munchie[:data][:attributes]).to have_key(:destination_city)
      expect(munchie[:data][:attributes][:destination_city]).to eq('Pueblo, CO')
      expect(munchie[:data][:attributes]).to have_key(:forecast)
      expect(munchie[:data][:attributes][:forecast]).to be_a(Hash)
      expect(munchie[:data][:attributes][:forecast]).to have_key(:summary)
      expect(munchie[:data][:attributes][:forecast][:summary]).to be_a(String)
      expect(munchie[:data][:attributes][:forecast][:summary]).to eq("Partly cloudy")
      expect(munchie[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(munchie[:data][:attributes][:forecast][:temperature]).to be_a(String)
      expect(munchie[:data][:attributes][:forecast][:temperature]).to eq("12.9")
      expect(munchie[:data][:attributes]).to have_key(:restaurant)
      expect(munchie[:data][:attributes][:restaurant]).to be_an(Hash)
      expect(munchie[:data][:attributes][:restaurant]).to have_key(:name)
      expect(munchie[:data][:attributes][:restaurant][:name]).to be_a(String)
      expect(munchie[:data][:attributes][:restaurant][:name]).to eq("La Forchetta Da Massi")
      expect(munchie[:data][:attributes][:restaurant]).to have_key(:address)
      expect(munchie[:data][:attributes][:restaurant][:address]).to be_a(String)
      expect(munchie[:data][:attributes][:restaurant][:address]).to eq("126 S Union Ave, Pueblo, CO 81003")
      expect(munchie[:data][:attributes][:restaurant]).to have_key(:rating)
      expect(munchie[:data][:attributes][:restaurant][:rating]).to be_a(Float)
      expect(munchie[:data][:attributes][:restaurant][:rating]).to eq(4.5)
      expect(munchie[:data][:attributes][:restaurant]).to have_key(:reviews)
      expect(munchie[:data][:attributes][:restaurant][:reviews]).to be_a(Integer)
      expect(munchie[:data][:attributes][:restaurant][:reviews]).to eq(230)
    end
  end
end 