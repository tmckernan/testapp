describe PaymentsController do
  let(:user) { create :user }
  let!(:recipient) { create :recipient, user: user }

  before do
    allow(controller).to receive :authenticate_user!
    allow(controller).to receive(:current_user) { user }
    allow(controller).to receive(:auth).and_return true
  end

  describe '#index' do
    it 'retrieves list of payment from api' do
      get :index, { recipient_id: recipient.id }
      expect(response.status).to eq 200
    end
  end

  describe '#create' do
    let(:params) do
      {
        recipient_id: recipient.id,
        payment: { amount: 10, currency: "GBP" }
      }
    end

    it 'sends money to recipient' do
      post :create, params
      expect(response).to redirect_to recipient_payments_path(recipient)
    end
  end
end
