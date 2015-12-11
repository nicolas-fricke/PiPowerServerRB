json.array!(@frequencies) do |frequency|
  json.extract! frequency, :id, :system_code, :socket_code, :is_on
  json.url frequency_url(frequency, format: :json)
end
