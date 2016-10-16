require 'spec_helper'
require 'rails_helper'

describe AccountsController do
  let(:user) { create :user }

  before do
    allow(controller).to receive :authenticate_user!
    allow(controller).to receive(:current_user) { user }
  end

  describe '#create' do
    context 'successful' do
      it 'creates and associates account to the user' do
        account_params = {
          account: { username: 'person', api_key: "0A1B2C3D4E" }
        }
        post :create, account_params
        expect(response).to redirect_to root_path
      end
    end

    context 'unsuccessful' do
      it 're-renders new page' do
        post :create, { account: { username: nil } }
        expect(response).to render_template :new
      end
    end
  end

  describe '#destroy' do
    let!(:cp_account) { create :account, user: user }

    it "destroys a user's account" do
      delete :destroy
      expect(response).to redirect_to root_path
    end
  end
end
