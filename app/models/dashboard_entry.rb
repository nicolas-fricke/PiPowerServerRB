class DashboardEntry < ActiveRecord::Base
  belongs_to :item, polymorphic: true
  validates :item, presence: true
  validates :item_id, uniqueness: { scope: :item_type }
end
