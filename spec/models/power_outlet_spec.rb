require 'rails_helper'

RSpec.describe PowerOutlet do
  describe 'validations' do
    let(:valid_power_outlet_params) { FactoryGirl.attributes_for :power_outlet }
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
      context 'missing system_code' do
        let(:missing_param) { :system_code }
        it { should_not be_valid }
      end
      context 'missing socket_code' do
        let(:missing_param) { :socket_code }
        it { should_not be_valid }
      end
    end
    describe 'system_code' do
      let(:params) { valid_power_outlet_params.merge(system_code: 'test') }
      it { should_not be_valid }
    end
    describe 'socket_code' do
      let(:params) { valid_power_outlet_params.merge(socket_code: 7) }
      it { should_not be_valid }
    end
  end

  describe 'callbacks' do
    context 'on is_on change' do
      let(:power_outlet) { FactoryGirl.create :power_outlet, is_on: false }
      it 'triggers a system call' do
        expect(power_outlet).to receive(:system).with(
          /switching\s+#{power_outlet.system_code}\s+#{power_outlet.socket_code}\s+1/
        )
        power_outlet.is_on = true
        power_outlet.save
      end
    end
    context 'on name change' do
      let(:power_outlet) { FactoryGirl.create :power_outlet }
      it 'does not trigger a system call' do
        expect(power_outlet).to_not receive(:system)
        power_outlet.name = 'A new name'
        power_outlet.save
      end
    end
  end
end
