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
end
