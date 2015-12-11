require 'rails_helper'

RSpec.describe PowerOutlet do
  describe 'validations' do
    let(:frequency) { FactoryGirl.create :frequency }
    let(:valid_power_outlet_params) { {name: 'Test', frequency: frequency} }
    let(:params) { valid_power_outlet_params }
    let(:new_power_outlet) { PowerOutlet.new params }
    subject { new_power_outlet }
    describe 'presence' do
      let(:missing_param) { :none }
      let(:params) { valid_power_outlet_params.except(missing_param) }
      context 'everything set' do
        it { should be_valid }
      end
      context 'missing name' do
        let(:missing_param) { :name }
        it { should_not be_valid }
      end
      context 'missing frequency' do
        let(:missing_param) { :frequency }
        it { should_not be_valid }
      end
    end
  end

  describe 'having relations' do
    let(:power_outlet) { FactoryGirl.create :power_outlet }
    context 'has_many power outlet groups' do
      let(:power_outlet_groups) do
        FactoryGirl.create_list :power_outlet_group, 2
      end
      it 'associates power outlets to group' do
        expect(power_outlet.power_outlet_groups).to be_empty
        power_outlet.power_outlet_groups = power_outlet_groups
        power_outlet.save
        expect(power_outlet.power_outlet_groups).to have(2).items
      end
    end
  end
end
