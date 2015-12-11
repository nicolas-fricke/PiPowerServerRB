FactoryGirl.define do
  factory :frequency do
    # mod 31 instead of 32 so that modolos of socket and system don't collide
    sequence(:system_code) {|n| (n % 31).to_s(2).rjust(5, '0') }
    sequence(:socket_code) {|n| n % 4 + 1 }
    is_on false
  end
end
