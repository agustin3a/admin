json.array!(@items) do |item|
  json.extract! item, :id, :name, :description, :type, :price, :initial_date, :expiry_date
  json.url item_url(item, format: :json)
end
