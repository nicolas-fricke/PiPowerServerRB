require 'rails_helper'

RSpec.describe SwitchesController do
  context 'when nested under PowerOutlet' do
    let(:initial_is_on) { false }
    let(:frequency) { FactoryGirl.create :frequency, is_on: initial_is_on }
    let(:power_outlet) do
      FactoryGirl.create :power_outlet, frequency: frequency
    end

    describe 'PUT #update' do
      let(:put_action) do
        -> { put :update, {power_outlet_id: power_outlet.id,
                           is_on: !initial_is_on,
                           format: :json } }
      end
      it 'should switch frequency on' do
        expect { put_action.call }
          .to change { Frequency.find(frequency.id).is_on }
            .from(initial_is_on).to(!initial_is_on)
      end
    end
  end

  context 'when nested under PowerOutletGroup' do
    let(:initial_is_on) { false }
    let(:frequency_1) { FactoryGirl.create :frequency, is_on: initial_is_on }
    let(:power_outlet_1) do
      FactoryGirl.create :power_outlet, frequency: frequency_1
    end
    let(:frequency_2) { FactoryGirl.create :frequency, is_on: initial_is_on }
    let(:power_outlet_2) do
      FactoryGirl.create :power_outlet, frequency: frequency_2
    end
    let(:power_outlet_group) do
      FactoryGirl.create :power_outlet_group,
                         power_outlets: [power_outlet_1, power_outlet_2]
    end

    describe 'PUT #update' do
      let(:put_action) do
        -> { put :update, {power_outlet_group_id: power_outlet_group.id,
                           is_on: !initial_is_on,
                           format: :json } }
      end
      it 'should switch frequency on' do
        expect { put_action.call }
          .to change { Frequency.all.map(&:is_on) }
            .from(all eq initial_is_on).to(all eq !initial_is_on)
      end
    end
  end
end
