describe RecipientsController do
  let(:user) { create :user }

  before do
    allow(controller).to receive :authenticate_user!
    allow(controller).to receive(:current_user) { user }
    allow(controller).to receive(:auth).and_return true
  end

  describe '#index' do
    let!(:new_recipient) { create :recipient, user: user }

    it 'retrieves list of recipients' do
      get :index
      expect(assigns(:recipients).size).to eq 1
      expect(response.status).to eq 200
    end
  end

  describe '#create' do
    it 'adds a new recipient' do
      post :create, recipient: { name: 'Ken Bone' }
      expect(response).to redirect_to recipients_path
    end
  end
end
