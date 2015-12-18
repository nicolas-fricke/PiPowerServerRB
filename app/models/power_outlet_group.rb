class PowerOutletGroup < ActiveRecord::Base
  has_and_belongs_to_many :power_outlets
  validates :name, presence: true

  after_save :save_frequencies

  def is_on
    values = power_outlets.map(&:is_on).uniq
    return nil if values.size > 1
    values == [true]
  end

  def is_on=(value)
    is_on_changed!
    power_outlets.map(&:frequency).uniq.each do |frequency|
      frequency.is_on = value
    end
  end

  def save_frequencies
    power_outlets.map(&:frequency).uniq.each(&:save) if is_on_changed?
  end

  private
  def is_on_changed!
    @is_on_changed = true
  end

  def is_on_changed?
    !!@is_on_changed
  end
end
