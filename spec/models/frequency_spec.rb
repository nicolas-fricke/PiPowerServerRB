require 'rails_helper'

RSpec.describe Frequency do
  describe 'validations' do
    let(:valid_frequency_params) { FactoryGirl.attributes_for :frequency }
    let(:params) { valid_frequency_params }
    let(:new_frequency) { Frequency.new params }
    subject { new_frequency }
    describe 'presence' do
      let(:missing_param) { :none }
      let(:params) { valid_frequency_params.except(missing_param) }
      context 'everything set' do
        it { should be_valid }
      end
      context 'missing system_code' do
        let(:missing_param) { :system_code }
        it { should_not be_valid }
      end
      context 'missing socket_code_human' do
        let(:missing_param) { :socket_code_human }
        it { should_not be_valid }
      end
    end
    describe 'system_code' do
      let(:params) { valid_frequency_params.merge(system_code: 'test') }
      it { should_not be_valid }
    end
    describe 'socket_code_human' do
      let(:params) { valid_frequency_params.merge(socket_code_human: 'x') }
      it { should_not be_valid }
    end
  end

  describe 'callbacks' do
    context 'on is_on change' do
      let(:frequency) { FactoryGirl.create :frequency, is_on: false }
      it 'triggers a system call' do
        expect(frequency).to receive(:system).with(
          /switching\s+#{frequency.system_code}\s+#{frequency.socket_code}\s+1/
        )
        frequency.is_on = true
        frequency.save
      end
    end
    context 'on socket_code change' do
      let(:frequency) { FactoryGirl.create :frequency, socket_code: 1 }
      it 'does not trigger a system call' do
        expect(frequency).to_not receive(:system)
        frequency.socket_code = 3
        frequency.save
      end
    end
  end

  describe '.socket_code_char_to_i' do
    subject { described_class.socket_code_char_to_i(char) }
    context 'when mapping exists' do
      context 'for capital char' do
        let(:char) { 'A' }
        it { should eq 1 }
      end
      context 'for lowercase char' do
        let(:char) { 'b' }
        it { should eq 2 }
      end
    end

    context 'when mapping does not exist' do
      let(:char) { 'X' }
      it { should be_nil }
    end
  end
end
