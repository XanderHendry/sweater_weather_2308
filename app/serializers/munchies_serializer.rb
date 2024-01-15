class MunchiesSerializer
  attr_reader :error_object

  def initialize(forecast, restaurant)
    @forecast = forecast
    @restaurant = restaurant[:businesses].first
  end

  def serialize_json
    serialized_hash = {
      "data": {}
    }
    serialized_hash[:data] = {
      "id": nil,
      "type": 'munchie',
      "attributes": {
        "destination_city": "#{@restaurant[:location][:city]}, #{@restaurant[:location][:state]}",
        "forecast": {
          "summary": @forecast[:current][:condition][:text],
          "temperature": @forecast[:current][:temp_f].to_s
        },
        "restaurant": {
          "name": @restaurant[:name],
          "address": "#{@restaurant[:location][:display_address].first}, #{@restaurant[:location][:display_address].last}",
          "rating": @restaurant[:rating],
          "reviews": @restaurant[:review_count]
        }
      }
    }
    serialized_hash
  end
end