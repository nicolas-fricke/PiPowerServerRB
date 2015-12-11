class PowerOutletGroup < ActiveRecord::Base
  has_and_belongs_to_many :power_outlets
  validates :name, presence: true
end
