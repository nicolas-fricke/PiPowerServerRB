json.array!(@power_outlet_groups) do |power_outlet_group|
  json.extract! power_outlet_group, :id, :name, :description, :permalink
  json.url power_outlet_group_url(power_outlet_group, format: :json)
end
