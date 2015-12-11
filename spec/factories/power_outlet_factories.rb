FactoryGirl.define do
  factory :power_outlet do
    name 'Desktop Lamp'
    location 'Desk in the office'
    system_code '10010'
    socket_code 3
    is_on false
  end
end
