class WeatherService
  def self.forecast_at_location(location_details, days)
    get_url("/v1/forecast.json?q=#{location_details[:lat]},#{location_details[:lon]}&days=#{days}")
  end

  def self.weather_at_eta(location_details, datetime)
    get_url("/v1/forecast.json?q=#{location_details[:lat]},#{location_details[:lon]}&dt=#{datetime}")
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: "http://api.weatherapi.com") do |faraday|
      faraday.params["key"] = Rails.application.credentials.weather_api[:key]
    end
  end
end
