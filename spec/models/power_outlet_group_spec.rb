require 'rails_helper'

RSpec.describe PowerOutletGroup do
  describe 'having validations' do
    let(:valid_power_outlet_group_params) { {name: 'Test'} }
    let(:params) { valid_power_outlet_group_params }
    let(:new_power_outlet_group) { PowerOutletGroup.new params }
    subject { new_power_outlet_group }
    describe 'presence' do
      let(:missing_param) { :none }
      let(:params) { valid_power_outlet_group_params.except(missing_param) }
      context 'everything set' do
        it { should be_valid }
      end
      context 'missing name' do
        let(:missing_param) { :name }
        it { should_not be_valid }
      end
    end
  end

  describe 'having relations' do
    let(:power_outlet_group) { FactoryGirl.create :power_outlet_group }
    context 'has_many power outlets' do
      let(:power_outlets) { FactoryGirl.create_list :power_outlet, 5 }
      it 'associates power outlets to group' do
        expect(power_outlet_group.power_outlets).to be_empty
        power_outlet_group.power_outlets = power_outlets
        power_outlet_group.save
        expect(power_outlet_group.power_outlets).to have(5).items
      end
    end
  end

  describe '#is_on' do
    let(:frequency_1) { FactoryGirl.create :frequency, is_on: is_on_freq_1 }
    let(:frequency_2) { FactoryGirl.create :frequency, is_on: is_on_freq_2 }
    let(:power_outlets_freq_1) do
      FactoryGirl.create_list :power_outlet, 3, frequency: frequency_1
    end
    let(:power_outlets_freq_2) do
      FactoryGirl.create_list :power_outlet, 2, frequency: frequency_2
    end
    let(:power_outlet_group) do
      FactoryGirl.create :power_outlet_group,
                         power_outlets: [
                           *power_outlets_freq_1,
                           *power_outlets_freq_2
                         ]
    end
    subject { power_outlet_group.is_on }
    context 'when both frequencies are on' do
      let(:is_on_freq_1) { true }
      let(:is_on_freq_2) { true }
      it { should be true }
    end
    context 'when both frequencies are off' do
      let(:is_on_freq_1) { false }
      let(:is_on_freq_2) { false }
      it { should be false }
    end
    context 'when one frequency is off and one is on' do
      let(:is_on_freq_1) { false }
      let(:is_on_freq_2) { true }
      it { should be nil }
    end
  end
end
