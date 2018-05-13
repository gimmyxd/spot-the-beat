module Uber
  def self.estimate_price start, finish, token
      uber.get('estimates/price') do |req|
        req.headers['Authorization: Bearer'] = token
        req.params['start_latitude'] = start[:latitude]
        req.params['start_longitude'] = start[:longitude]
        req.params['end_latitdue'] = finish[:latitude]
        req.params['end_longitude'] = finish[:longitude]
      end.body
  end

  def self.products where, token
    uber(token).get('products') do |req|
      req.params['latitude'] = where[:lat]
      req.params['longitude'] = where[:long]
    end.body
  end

  private
  def self.uber token
    Faraday.new("https://api.uber.com/v1.2/") do |conn|
      conn.use FaradayMiddleware::FollowRedirects;
      conn.response :json, :content_type => /\bjson$/
      conn.request :url_encoded
      conn.response(:logger, ::Logger.new(STDOUT), bodies: true)
      conn.authorization :Bearer, token
      # Last middleware must be the adapter:
      conn.adapter :net_http
    end
  end

end