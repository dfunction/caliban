json.array!(@pointers) do |pointer|
  json.extract! pointer, :id, :type, :value, :contact_id
  json.url pointer_url(pointer, format: :json)
end
