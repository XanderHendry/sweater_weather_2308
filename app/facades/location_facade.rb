class LocationFacade
  def self.get_location_data(location)
    response = MapService.get_location_data(location)
    location_data = {
      lat: response[:results].first[:locations].first[:latLng][:lat],
      lng: response[:results].first[:locations].first[:latLng][:lng]
    }
  end
end
