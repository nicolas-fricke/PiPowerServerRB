json.extract! @switch_subject, :id, :name, :is_on
case @switch_subject
when PowerOutlet
  json.url power_outlet_url(@switch_subject, format: :json)
when PowerOutletGroup
  json.url power_outlet_group_url(@switch_subject, format: :json)
end
