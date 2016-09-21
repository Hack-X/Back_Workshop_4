json.array!(@shows) do |show|
  json.extract! show, :id, :name, :venue, :description, :capacity, :price, :image, :date, :lat, :lng
  json.url show_url(show, format: :json)
end
