class ForecastSerializer
  attr_reader :error_object

  def initialize(location)
    @forecast = WeatherService.forecast_at_location(location, 5)
  end

  def serialize_json
    serialized_hash = {
      "data": {}
    }
    serialized_hash[:data] = {
      "id": nil,
      "type": 'forecast',
      "attributes": {
        "current_weather": {
          "last_updated": @forecast[:current][:last_updated],
          "temperature": @forecast[:current][:temp_f],
          "feels_like": @forecast[:current][:feelslike_f],
          "humidity": @forecast[:current][:humidity],
          "uvi": @forecast[:current][:uv],
          "visibility": @forecast[:current][:vis_miles],
          "condition": @forecast[:current][:condition][:text],
          "icon": @forecast[:current][:condition][:icon]
        },
        "daily_weather": [],
        "hourly_weather": []
      }
    }
      @forecast[:forecast][:forecastday].each do |day|
      serialized_hash[:data][:attributes][:daily_weather] << {
        "date": day[:date],
        "sunrise": day[:astro][:sunrise],
        "sunset": day[:astro][:sunset],
        "max_temp": day[:day][:maxtemp_f],
        "min_temp": day[:day][:mintemp_f],
        "condition": day[:day][:condition][:text],
        "icon": day[:day][:condition][:icon]
      }
        day[:hour].each do |hour|
          serialized_hash[:data][:attributes][:hourly_weather] <<
        {
          "time": hour[:time],
          "temperature": hour[:temp_f],
          "conditions": hour[:condition][:text],
          "icon": hour[:condition][:icon] 
        }
        end
      end
    serialized_hash
  end
end