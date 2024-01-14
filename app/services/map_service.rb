class MapService
  def self.get_location_data(location)
    get_url("/geocoding/v1/address?location=#{location}")
  end
  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: "https://www.mapquestapi.com") do |faraday|
      faraday.params["key"] = Rails.application.credentials.mapquest_api[:key]
    end
  end
end
