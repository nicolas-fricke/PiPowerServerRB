class PowerOutlet < ActiveRecord::Base
  belongs_to :frequency

  validates :name, :frequency, presence: true
end
