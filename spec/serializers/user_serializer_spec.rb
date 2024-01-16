require 'rails_helper'

RSpec.describe UsersSerializer do
  it 'formats data from the WeatherService response', :vcr do
    user = build(:user)
    user.save
    output = UsersSerializer.new(user).serializable_hash
    expect(output).to have_key(:data)
    expect(output[:data]).to be_an(Hash)
    expect(output[:data]).to have_key(:id)
    expect(output[:data][:id]).to eq(user.id.to_s)
    expect(output[:data]).to have_key(:type)
    expect(output[:data][:type]).to eq(:users)
    expect(output[:data]).to have_key(:attributes)
    expect(output[:data][:attributes]).to be_a(Hash)
    expect(output[:data][:attributes]).to have_key(:email)
    expect(output[:data][:attributes][:email]).to be_a(String)
    expect(output[:data][:attributes]).to have_key(:api_key)
    expect(output[:data][:attributes][:api_key]).to be_a(String)
   

  end
end