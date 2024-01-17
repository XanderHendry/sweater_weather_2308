class RoadTrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta
  def initialize(roadtrip_data)
    @id = nil
    @start_city = roadtrip_data[:start_city]
    @end_city = roadtrip_data[:end_city]
    @travel_time = roadtrip_data[:travel_time]
    @weather_at_eta = roadtrip_data[:weather_at_eta]
  end
end
