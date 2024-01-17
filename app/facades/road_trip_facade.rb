class RoadTripFacade
  def self.plan_roadtrip(trip_data)
    route = MapService.get_directions(trip_data[:origin], trip_data[:destination])
    eta = estimated_time_of_arrival(route)
    forecast = WeatherService.weather_at_eta({ 
      lat: route[:route][:locations].last[:latLng][:lat], 
      lon: route[:route][:locations].last[:latLng][:lng]
    }, eta[:formatted_eta])
    final_forecast = weather_at_eta(eta, forecast)
    road_trip = RoadTrip.new({ 
      start_city: trip_data[:origin],
      end_city: trip_data[:destination],
      travel_time: route[:route][:formattedTime],
      weather_at_eta: {
        "datetime": eta[:formatted_eta],
        "temperature": final_forecast[:temp_f],
        "condition": final_forecast[:condition][:text]
      }
    })
  end

  private
  
  def self.weather_at_eta(eta, forecast)
    search_time = eta[:real_eta].strftime("%Y-%m-%d %H:00")
    forecast[:forecast][:forecastday][0][:hour].find do |hash|
      hash[:time] == search_time
    end
  end

  def self.estimated_time_of_arrival(route)
    current_time = Time.now
    elapsed_time_seconds = route[:route][:realTime]
    estimated_arrival_time = current_time + elapsed_time_seconds
  
    # Format the estimated arrival time as a string
    result = {real_eta: estimated_arrival_time, formatted_eta: estimated_arrival_time.strftime("%Y-%m-%d %H:%M")}
  end
end