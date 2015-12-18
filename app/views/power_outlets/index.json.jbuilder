json.array!(@power_outlets) do |power_outlet|
  json.extract! power_outlet, :id, :name, :location, :is_on
  json.url power_outlet_url(power_outlet, format: :json)
end
