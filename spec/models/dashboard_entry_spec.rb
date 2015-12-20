require 'rails_helper'

RSpec.describe DashboardEntry, type: :model do
  describe 'new entry' do
    let(:power_outlet) { FactoryGirl.create :power_outlet }
    it 'should be a successfully created dashboard_entry' do
      expect { DashboardEntry.create(position: 1, item: power_outlet) }
        .to change { DashboardEntry.count }.from(0).to(1)
    end
  end
end
