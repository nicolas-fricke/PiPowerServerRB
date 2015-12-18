class PowerOutlet < ActiveRecord::Base
  belongs_to :frequency
  has_and_belongs_to_many :power_outlet_groups
  validates :name, :frequency, presence: true

  after_save :save_frequency

  def is_on
    frequency.is_on
  end

  def is_on=(value)
    frequency.is_on = value
  end

  def save_frequency
    frequency.save if frequency.changed?
  end
end
