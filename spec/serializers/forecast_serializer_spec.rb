require 'rails_helper'

RSpec.describe ForecastSerializer do
  it 'formats data from the WeatherService response', :vcr do
    response = ForecastSerializer.new(WeatherService.forecast_at_location({lat: '33.95', lon: '-81.12'}, 5))
    output = response.serialize_json
    expect(output).to have_key(:data)
    expect(output[:data]).to be_an(Array)
    
    weather_data = output[:data].first
    expect(weather_data).to have_key(:id)
    expect(weather_data[:id]).to be_nil
    expect(weather_data).to have_key(:type)
    expect(weather_data[:type]).to eq('forecast')
    expect(weather_data).to have_key(:attributes)
    expect(weather_data[:attributes]).to be_a(Hash)
    weather_attributes = weather_data[:attributes]
    expect(weather_attributes).to have_key(:current_weather)
    expect(weather_attributes[:current_weather]).to be_a(Hash)
    expect(weather_attributes).to have_key(:daily_weather)
    expect(weather_attributes[:daily_weather]).to be_a(Array)
    expect(weather_attributes[:daily_weather].count).to eq(5)
    expect(weather_attributes).to have_key(:hourly_weather)
    expect(weather_attributes[:hourly_weather]).to be_a(Array)
    expect(weather_attributes[:hourly_weather].count).to eq(24)
    current_weather = weather_attributes[:current_weather]
    expect(current_weather).to have_key(:last_updated)
    expect(current_weather[:last_updated]).to be_a(String)
    expect(current_weather).to have_key(:temperature)
    expect(current_weather[:temperature]).to be_a(Float)
    expect(current_weather).to have_key(:feels_like)
    expect(current_weather[:feels_like]).to be_a(Float)
    expect(current_weather).to have_key(:humidity)
    expect(current_weather[:humidity]).to be_a(Float)
    expect(current_weather).to have_key(:uvi)
    expect(current_weather[:uvi]).to be_a(Float)
    expect(current_weather).to have_key(:visibility)
    expect(current_weather[:visibility]).to be_a(Float)
    expect(current_weather).to have_key(:condition)
    expect(current_weather[:condition]).to be_a(String)
    expect(current_weather).to have_key(:icon)
    # expect(current_weather[:icon]).to be_a(PNG)
    daily_weather = weather_attributes[:daily_weather].first
    expect(daily_weather).to have_key(:date)
    expect(daily_weather[:date]).to be_a(String)
    expect(daily_weather).to have_key(:sunrise)
    expect(daily_weather[:sunrise]).to be_a(String)
    expect(daily_weather).to have_key(:sunset)
    expect(daily_weather[:sunset]).to be_a(String)
    expect(daily_weather).to have_key(:max_temp)
    expect(daily_weather[:max_temp]).to be_a(Float)
    expect(daily_weather).to have_key(:min_temp)
    expect(daily_weather[:min_temp]).to be_a(Float)
    expect(daily_weather).to have_key(:condition)
    expect(daily_weather[:condition]).to be_a(String)
    expect(daily_weather).to have_key(:icon)
    # expect(daily_weather[:icon]).to be_a(PNG)
    hourly_weather = weather_attributes[:hourly_weather].first
    expect(daily_weather).to have_key(:time)
    expect(daily_weather[:time]).to be_a(String)
    expect(daily_weather).to have_key(:temperature)
    expect(daily_weather[:temperature]).to be_a(Float)
    expect(daily_weather).to have_key(:conditions)
    expect(daily_weather[:conditions]).to be_a(String)
    expect(daily_weather).to have_key(:icon)
    # expect(daily_weather[:icon]).to be_a(PNG)

  end
end