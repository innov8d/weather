class LocationStorage
  include HTTParty
  base_uri 'https://api.radar.io/v1/geocode'

  def initialize
    self.class.headers 'Authorization' => ENV['RADAR_KEY']
  end

  # Gets the latitude and longitude for a supplied address.
  # Returns an object {latitude, longitude, postalCode}
  def addressToCoords(address)
    raise ArgumentError, 'you must search for something' if address.blank?

    response = get_location(address)

    raise NoAddressesError, 'No info for that address' unless response.key?('addresses')
    raise NoAddressesError, 'No info for that address' unless response['addresses'].length > 0

    location = response['addresses'].first
    {latitude: location['latitude'].round(3), longitude: location['longitude'].round(3), postalCode: location['postalCode']}
  end

  def get_location(address)
    @options = { query: { query: address }}
    self.class.get("/forward", @options)
  end
end
