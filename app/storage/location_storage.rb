class LocationStorage
  include HTTParty
  base_uri 'https://api.radar.io/v1/geocode'

  def initialize
    self.class.headers 'Authorization' => ENV['RADAR_KEY']
  end

  def addressToCoords(address)
    raise ArgumentError, 'you must search for something' if address.blank?

    @options = { query: { query: address }}
    response = self.class.get("/forward", @options)

    raise RuntimeError, 'No info for that address' unless response.key?('addresses')
    raise RuntimeError, 'No info for that address' unless response['addresses'].length > 0

    location = response['addresses'].first
    {latitude: location['latitude'], longitude: location['longitude'], postalCode: location['postalCode']}
  end
end
