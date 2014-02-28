json.array!(@pings) do |ping|
  json.extract! ping, :id, :frequency, :type, :lastRun, :user_id
  json.url ping_url(ping, format: :json)
end
