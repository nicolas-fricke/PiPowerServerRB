FactoryGirl.define do
  factory :dashboard_entry do
    sequence(:position) {|n| n }
    power_outlet
  end
end
