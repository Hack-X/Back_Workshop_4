json.array!(@shows) do |show|
  json.extract! show, :id, :name, :location, :description, :capacity, :price, :image
  json.url show_url(show, format: :json)
end
