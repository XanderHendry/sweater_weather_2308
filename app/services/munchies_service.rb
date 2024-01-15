class MunchiesService
  def self.restaurant_rec(destination, food)
    get_url("v3/businesses/search?location=#{destination}&term=#{food}&sort_by=best_match&limit=1")
  end
  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: "https://api.yelp.com") do |faraday|
      faraday.headers["Authorization"] = Rails.application.credentials.yelp_api[:key]
    end
  end
end