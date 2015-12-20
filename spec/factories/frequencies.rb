FactoryGirl.define do
  factory :frequency do
    sequence(:system_code) {|n| (n % 32).to_s(2).rjust(5, '0') }
    sequence(:socket_code_human) {|n| ('A'..'E').to_a[n % 5] }
    is_on false
  end
end
