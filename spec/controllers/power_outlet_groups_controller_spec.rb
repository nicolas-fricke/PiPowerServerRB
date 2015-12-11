require 'rails_helper'

RSpec.describe PowerOutletGroupsController do
  let(:power_outlet_group) { FactoryGirl.create :power_outlet_group }

  describe 'GET #index' do
    before do
      power_outlet_group
      get :index
    end
    it 'assigns all power_outlet_groups as @power_outlet_groups' do
      expect(assigns(:power_outlet_groups)).to eq([power_outlet_group])
    end
    describe 'response' do
      subject { response }
      it { should have_http_status(:ok) }
      it { should render_template(:index) }
    end
  end

  describe 'GET #show' do
    before do
      get :show, {id: power_outlet_group.id}
    end
    it 'assigns the requested power_outlet_group as @power_outlet_group' do
      expect(assigns(:power_outlet_group)).to eq(power_outlet_group)
    end
    describe 'response' do
      subject { response }
      it { should have_http_status(:ok) }
      it { should render_template(:show) }
    end
  end

  describe 'GET #new' do
    before { get :new }
    it 'assigns a new power_outlet_group as @power_outlet_group' do
      expect(assigns(:power_outlet_group)).to be_a_new(PowerOutletGroup)
    end
    describe 'response' do
      subject { response }
      it { should have_http_status(:ok) }
      it { should render_template(:new) }
    end
  end

  describe 'GET #edit' do
    before { get :edit, {id: power_outlet_group.id} }
    it 'assigns the requested power_outlet_group as @power_outlet_group' do
      expect(assigns(:power_outlet_group)).to eq(power_outlet_group)
    end
    describe 'response' do
      subject { response }
      it { should have_http_status(:ok) }
      it { should render_template(:edit) }
    end
  end

  describe 'POST #create' do
    let(:params) { FactoryGirl.attributes_for(:power_outlet_group) }
    let(:post_action) { -> { post :create, { power_outlet_group: params } } }
    context 'with valid params' do
      it 'creates a new PowerOutletGroup' do
        expect { post_action.call }.to change(PowerOutletGroup, :count).by(1)
      end

      it 'assigns a newly created power_outlet_group as @power_outlet_group' do
        post_action.call
        expect(assigns(:power_outlet_group)).to be_a(PowerOutletGroup)
        expect(assigns(:power_outlet_group)).to be_persisted
      end

      it 'redirects to the created power_outlet_group' do
        post_action.call
        expect(response).to redirect_to(PowerOutletGroup.last)
      end
    end

    context 'with invalid params' do
      let(:params) { {name: nil} }
      before { post_action.call }
      it 'assigns a newly created but unsaved power_outlet_group as @power_outlet_group' do
        expect(assigns(:power_outlet_group)).to be_a_new(PowerOutletGroup)
      end

      it 're-renders the `new` template' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    let(:power_outlet_group) do
      FactoryGirl.create :power_outlet_group, name: 'My lamp group'
    end
    let(:new_attributes) { {} }
    let(:put_action) do
      -> { put :update,
               {id: power_outlet_group.id, power_outlet_group: new_attributes} }
    end
    context 'with valid params' do
      let(:new_attributes) { {name: 'Your lamp group'} }
      it 'updates the requested power_outlet_group' do
        put_action.call
        expect(power_outlet_group.name).to eq 'My lamp group'
        power_outlet_group.reload
        expect(power_outlet_group.name).to eq 'Your lamp group'
      end

      it 'assigns the requested power_outlet_group as @power_outlet_group' do
        put_action.call
        expect(assigns(:power_outlet_group)).to eq(power_outlet_group)
      end

      it 'redirects to the power_outlet_group' do
        put_action.call
        expect(response).to redirect_to(power_outlet_group)
      end
    end

    context 'with invalid params' do
      let(:new_attributes) { {name: nil} }
      it 'assigns the power_outlet_group as @power_outlet_group' do
        put_action.call
        expect(assigns(:power_outlet_group)).to eq(power_outlet_group)
      end

      it 're-renders the `edit` template' do
        put_action.call
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:destroy_action) { -> { delete :destroy, {id: power_outlet_group.id} } }
    before { power_outlet_group }
    it 'destroys the requested power_outlet_group' do
      expect { destroy_action.call }.to change(PowerOutletGroup, :count).by(-1)
    end

    it 'redirects to the power_outlet_groups list' do
      destroy_action.call
      expect(response).to redirect_to(power_outlet_groups_url)
    end
  end
end
