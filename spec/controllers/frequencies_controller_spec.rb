require 'rails_helper'

RSpec.describe FrequenciesController do
  let(:frequency) { FactoryGirl.create :frequency }

  describe 'GET #index' do
    before do
      frequency
      get :index
    end
    it 'assigns all frequencies as @frequencies' do
      expect(assigns(:frequencies)).to eq([frequency])
    end
    describe 'response' do
      subject { response }
      it { should have_http_status(:ok) }
      it { should render_template(:index) }
    end
  end

  describe 'GET #show' do
    before do
      get :show, {id: frequency.id}
    end
    it 'assigns the requested frequency as @frequency' do
      expect(assigns(:frequency)).to eq(frequency)
    end
    describe 'response' do
      subject { response }
      it { should have_http_status(:ok) }
      it { should render_template(:show) }
    end
  end

  describe 'GET #new' do
    before { get :new }
    it 'assigns a new frequency as @frequency' do
      expect(assigns(:frequency)).to be_a_new(Frequency)
    end
    describe 'response' do
      subject { response }
      it { should have_http_status(:ok) }
      it { should render_template(:new) }
    end
  end

  describe 'GET #edit' do
    before { get :edit, {id: frequency.id} }
    it 'assigns the requested frequency as @frequency' do
      expect(assigns(:frequency)).to eq(frequency)
    end
    describe 'response' do
      subject { response }
      it { should have_http_status(:ok) }
      it { should render_template(:edit) }
    end
  end

  describe 'POST #create' do
    let(:params) { FactoryGirl.attributes_for(:frequency) }
    let(:post_action) { -> { post :create, {frequency: params} } }
    context 'with valid params' do
      it 'creates a new Frequency' do
        expect { post_action.call }.to change(Frequency, :count).by(1)
      end

      it 'assigns a newly created frequency as @frequency' do
        post_action.call
        expect(assigns(:frequency)).to be_a(Frequency)
        expect(assigns(:frequency)).to be_persisted
      end

      it 'redirects to the created frequency' do
        post_action.call
        expect(response).to redirect_to(Frequency.last)
      end
    end

    context 'with invalid params' do
      let(:params) { {socket_code: 12} }
      before { post_action.call }
      it 'assigns a newly created but unsaved frequency as @frequency' do
        expect(assigns(:frequency)).to be_a_new(Frequency)
      end

      it 're-renders the `new` template' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    let(:frequency) { FactoryGirl.create :frequency, is_on: false }
    let(:new_attributes) { {} }
    let(:put_action) do
      -> { put :update, {id: frequency.id, frequency: new_attributes} }
    end
    context 'with valid params' do
      let(:new_attributes) { {is_on: true} }
      it 'updates the requested frequency' do
        put_action.call
        expect(frequency.is_on).to be false
        frequency.reload
        expect(frequency.is_on).to be true
      end

      it 'assigns the requested frequency as @frequency' do
        put_action.call
        expect(assigns(:frequency)).to eq(frequency)
      end

      it 'redirects to the frequency' do
        put_action.call
        expect(response).to redirect_to(frequency)
      end
    end

    context 'with invalid params' do
      let(:new_attributes) { {socket_code: '1234'} }
      it 'assigns the frequency as @frequency' do
        put_action.call
        expect(assigns(:frequency)).to eq(frequency)
      end

      it 're-renders the `edit` template' do
        put_action.call
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:destroy_action) { -> { delete :destroy, {id: frequency.id} } }
    before { frequency }
    it 'destroys the requested frequency' do
      expect { destroy_action.call }.to change(Frequency, :count).by(-1)
    end

    it 'redirects to the frequencies list' do
      destroy_action.call
      expect(response).to redirect_to(frequencies_url)
    end
  end
end
