json.array!(@listings) do |listing|
  json.extract! listing, :id, :name, :race, :raceday, :cause
  json.url listing_url(listing, format: :json)
end
