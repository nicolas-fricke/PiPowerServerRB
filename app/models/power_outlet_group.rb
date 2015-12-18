class PowerOutletGroup < ActiveRecord::Base
  has_and_belongs_to_many :power_outlets
  validates :name, presence: true

  def is_on
    values = power_outlets.map(&:is_on).uniq
    return nil if values.size > 1
    values == [true]
  end
end
