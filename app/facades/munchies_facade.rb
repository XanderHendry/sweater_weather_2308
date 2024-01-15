class MunchiesFacade
  attr_reader :location,
              :food
  def initialize(location, food)
    @location = location
    @food = food
  end

  def weather_data
    lat_lng = LocationFacade.get_location_data(@location)
    forecast = WeatherService.forecast_at_location(lat_lng, 1)
  end

  def restaurant_rec
    restaurant = MunchiesService.restaurant_rec(@location, @food)
  end

  def restaurant_rec_and_weather
    serialized_json = MunchiesSerializer.new(weather_data, restaurant_rec).serialize_json
  end
end