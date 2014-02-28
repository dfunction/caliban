json.array!(@users) do |user|
  json.extract! user, :id, :eid, :name, :phoneNumber, :email
  json.url user_url(user, format: :json)
end
