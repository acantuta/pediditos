json.array!(@promociones) do |promocion|
  json.extract! promocion, :id, :link
  json.url promocion_url(promocion, format: :json)
end
