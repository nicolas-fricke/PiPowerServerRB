class PowerOutlet < ActiveRecord::Base
  belongs_to :frequency
  has_and_belongs_to_many :power_outlet_groups
  validates :name, :frequency, presence: true

  delegate :is_on, :is_on=, to: :ensured_frequency
  after_save :save_frequency

  def save_frequency
    frequency.save if frequency.changed?
  end

  private
  def ensured_frequency
    frequency || Frequency.new
  end
end
