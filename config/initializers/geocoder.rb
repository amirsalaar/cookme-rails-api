# Geocoder::Configuration.lookup = :geocoder_ca
Geocoder::Configuration.timeout = 5
Geocoder.configure(
  lookup: :google,
  ip_lookup: :maxmind, 
  api_key: ENV['GOOGLE_GEOCODING'],
  use_https: true,
  timeout: 3,
  units: :km
)
