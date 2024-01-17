class RoadTripFacade
  def self.plan_roadtrip(trip_data)
    route = get_route(trip_data)
    if route[:info][:statuscode] != 0
      road_trip = impossible_route(trip_data)
    else
      eta = calculate_eta(route)
      forecast = weather_at_eta(route, eta)
      road_trip = RoadTrip.new({ 
        start_city: trip_data[:origin],
        end_city: trip_data[:destination],
        travel_time: route[:route][:formattedTime],
        weather_at_eta: {
          "datetime": eta[:formatted_eta],
          "temperature": forecast[:temp_f],
          "condition": forecast[:condition][:text]
        }
      })
    end
  end

  private

  def self.impossible_route(trip_data)
    road_trip = RoadTrip.new({
        start_city: trip_data[:origin],
        end_city: trip_data[:destination],
        travel_time: 'Impossible',
        weather_at_eta: {}
      })
  end

  def self.get_route(trip_data)
    route = MapService.get_directions(trip_data[:origin], trip_data[:destination])
  end
  
  def self.weather_at_eta(route, eta)
    search_time = eta[:real_eta].strftime("%Y-%m-%d %H:00")
    forecast = get_forecast(route, eta)
    forecast[:forecast][:forecastday][0][:hour].find do |hash|
      hash[:time] == search_time
    end
  end

  def self.get_forecast(route, eta)
    forecast = WeatherService.weather_at_eta({ 
        lat: route[:route][:locations].last[:latLng][:lat], 
        lon: route[:route][:locations].last[:latLng][:lng]
      }, eta[:formatted_eta])
  end

  # def self.weather_at_eta(eta, forecast)
  #   search_time = eta[:real_eta].strftime("%Y-%m-%d %H:00")
  #   forecast[:forecast][:forecastday][0][:hour].find do |hash|
  #     hash[:time] == search_time
  #   end
  # end

  def self.calculate_eta(route)
    eta = Time.now + route[:route][:realTime]
    result = {real_eta: eta, formatted_eta: eta.strftime("%Y-%m-%d %H:%M")}
  end
end