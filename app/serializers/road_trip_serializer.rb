class RoadTripSerializer
  def initialize(road_trip)
    @road_trip = road_trip
  end

  def serialize_json
    serialized_hash = {
      "data": {}
    }
    serialized_hash[:data] = {
      "id": 'Null',
      "type": 'road_trip',
      "attributes": {
        "start_city": @road_trip.start_city,
        "end_city": @road_trip.end_city,
        "travel_time": @road_trip.travel_time,
        "weather_at_eta": @road_trip.weather_at_eta,
      }
    }
    serialized_hash
  end
end
