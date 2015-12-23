require 'rails_helper'

RSpec.describe PowerOutletsController do
  let(:power_outlet) { FactoryGirl.create :power_outlet }

  describe 'GET #index' do
    before do
      power_outlet
      get :index
    end
    it 'assigns all power_outlets as @power_outlets' do
      expect(assigns(:power_outlets)).to eq([power_outlet])
    end
    describe 'response' do
      subject { response }
      it { should have_http_status(:ok) }
      it { should render_template(:index) }
    end
  end

  describe 'GET #show' do
    before do
      get :show, {id: power_outlet.id}
    end
    it 'assigns the requested power_outlet as @power_outlet' do
      expect(assigns(:power_outlet)).to eq(power_outlet)
    end
    describe 'response' do
      subject { response }
      it { should have_http_status(:ok) }
      it { should render_template(:show) }
    end
  end

  describe 'GET #new' do
    before { get :new }
    it 'assigns a new power_outlet as @power_outlet' do
      expect(assigns(:power_outlet)).to be_a_new(PowerOutlet)
    end
    describe 'response' do
      subject { response }
      it { should have_http_status(:ok) }
      it { should render_template(:new) }
    end
  end

  describe 'GET #edit' do
    before { get :edit, {id: power_outlet.id} }
    it 'assigns the requested power_outlet as @power_outlet' do
      expect(assigns(:power_outlet)).to eq(power_outlet)
    end
    describe 'response' do
      subject { response }
      it { should have_http_status(:ok) }
      it { should render_template(:edit) }
    end
  end

  describe 'POST #create' do
    let(:frequency) { FactoryGirl.create :frequency }
    let(:params) { FactoryGirl.attributes_for(:power_outlet) }
    let(:post_action) do
      -> do
        post :create, {
          power_outlet: params,
          frequency: {
            system_code: frequency.system_code,
            socket_code_human: frequency.socket_code_human
          }
        }
      end
    end
    context 'with valid params' do
      it 'creates a new PowerOutlet' do
        expect { post_action.call }.to change(PowerOutlet, :count).by(1)
      end

      it 'assigns a newly created power_outlet as @power_outlet' do
        post_action.call
        expect(assigns(:power_outlet)).to be_a(PowerOutlet)
        expect(assigns(:power_outlet)).to be_persisted
      end

      it 'redirects to the created power_outlet' do
        post_action.call
        expect(response).to redirect_to(PowerOutlet.last)
      end
    end

    context 'with invalid params' do
      let(:params) { {name: nil} }
      before { post_action.call }
      it 'assigns a newly created but unsaved power_outlet as @power_outlet' do
        expect(assigns(:power_outlet)).to be_a_new(PowerOutlet)
      end

      it 're-renders the `new` template' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    let(:power_outlet) { FactoryGirl.create :power_outlet, name: 'My lamp' }
    let(:new_attributes) { {} }
    let(:put_action) do
      -> { put :update, {id: power_outlet.id, power_outlet: new_attributes} }
    end
    context 'with valid params' do
      let(:new_attributes) { {name: 'Your lamp'} }
      it 'updates the requested power_outlet' do
        put_action.call
        expect(power_outlet.name).to eq 'My lamp'
        power_outlet.reload
        expect(power_outlet.name).to eq 'Your lamp'
      end

      it 'assigns the requested power_outlet as @power_outlet' do
        put_action.call
        expect(assigns(:power_outlet)).to eq(power_outlet)
      end

      it 'redirects to the power_outlet' do
        put_action.call
        expect(response).to redirect_to(power_outlet)
      end
    end

    context 'with invalid params' do
      let(:new_attributes) { {name: nil} }
      it 'assigns the power_outlet as @power_outlet' do
        put_action.call
        expect(assigns(:power_outlet)).to eq(power_outlet)
      end

      it 're-renders the `edit` template' do
        put_action.call
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:destroy_action) { -> { delete :destroy, {id: power_outlet.id} } }
    before { power_outlet }
    it 'destroys the requested power_outlet' do
      expect { destroy_action.call }.to change(PowerOutlet, :count).by(-1)
    end

    it 'redirects to the power_outlets list' do
      destroy_action.call
      expect(response).to redirect_to(power_outlets_url)
    end
  end
end
