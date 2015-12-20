class DashboardEntry < ActiveRecord::Base
  belongs_to :item, polymorphic: true
  validates :position, :item, presence: true
  validates :position, uniqueness: true
  validates :item_id, uniqueness: { scope: :item_type }
end
