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

  describe '#is_on' do
    let(:is_on) { true }
    let(:frequency) { FactoryGirl.create :frequency, is_on: is_on }
    let(:power_outlet) do
      FactoryGirl.create :power_outlet, frequency: frequency
    end
    subject { power_outlet.is_on }

    context 'when is_on == true' do
      let(:is_on) { true }
      it { should eq is_on }
    end

    context 'when is_on == false' do
      let(:is_on) { false }
      it { should eq is_on }
    end
  end

  describe '#is_on=' do
    let(:is_on) { true }
    let(:frequency) { FactoryGirl.create :frequency, is_on: is_on }
    let(:power_outlet) do
      FactoryGirl.create :power_outlet, frequency: frequency
    end
    it 'changes the is_on state of the associated frequency' do
      expect { power_outlet.is_on = !is_on }
        .to change { power_outlet.frequency.is_on }
          .from(is_on).to(!is_on)
    end
  end

  describe '#save' do
    describe 'accociated frequency' do
      let(:frequency) { FactoryGirl.create :frequency, is_on: old_is_on }
      let(:power_outlet) do
        FactoryGirl.create :power_outlet, frequency: frequency
      end

      context 'when is_on is true' do
        let(:old_is_on) { true }
        context 'and new state is false' do
          let(:new_is_on) { !old_is_on }
          it 'should set the frequency to new state' do
            power_outlet.is_on = new_is_on
            expect { power_outlet.save }
              .to change { Frequency.find(frequency.id).is_on }
              .from(old_is_on).to(new_is_on)
          end
        end
        context 'and new state is also true' do
          let(:new_is_on) { old_is_on }
          it 'should not change the frequency' do
            power_outlet.is_on = new_is_on
            expect { power_outlet.save }
              .not_to change { Frequency.find(frequency.id).is_on }
          end
        end
      end

      context 'when is_on is false' do
        let(:old_is_on) { false }
        context 'and new state is also false' do
          let(:new_is_on) { old_is_on }
          it 'should set the frequency to new state' do
            power_outlet.is_on = new_is_on
            expect { power_outlet.save }
              .not_to change { Frequency.find(frequency.id).is_on }
          end
        end
        context 'and new state is true' do
          let(:new_is_on) { !old_is_on }
          it 'should not change the frequency' do
            power_outlet.is_on = new_is_on
            expect { power_outlet.save }
              .to change { Frequency.find(frequency.id).is_on }
              .from(old_is_on).to(new_is_on)
          end
        end
      end
    end
  end
end
