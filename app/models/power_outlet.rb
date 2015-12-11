class PowerOutlet < ActiveRecord::Base
  belongs_to :frequency
  has_and_belongs_to_many :power_outlet_groups
  validates :name, :frequency, presence: true
end
