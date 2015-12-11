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
end
