class WeatherStorage
  include HTTParty
  base_uri 'https://api.tomorrow.io/v4/weather/'

  def weatherForCoords(coords)
    lat = coords[:latitude]
    long = coords[:longitude]

    query = {
      apikey: ENV['TOMORROW_KEY'], 
      location: "#{lat},#{long}",
      fields: 'temperature',
      units: 'imperial',
      timesteps: '1d', 
      endTime: 'nowPlus5D' 
    }

    self.class.get('/forecast', { query: query })
  end
end
