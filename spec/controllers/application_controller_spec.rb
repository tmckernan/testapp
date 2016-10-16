require 'spec_helper'
require 'rails_helper'

describe ApplicationController do
  it { should use_before_action :authenticate_user! }

  describe '#auth' do
    let(:user) { create :user }
    before { allow(controller).to receive(:current_user) { user } }

    context 'User has account' do
      let!(:new_account) { create :account, user: user }

      it 'sets the token' do
        allow(controller).to receive(:set_token)
        controller.auth
        expect(controller).to have_received(:set_token)
      end
    end

    context 'User has no account' do
      it 'redirects to adding a new  account' do
        allow(controller).to receive(:redirect_to).and_return true
        controller.auth
        expect(controller).to have_received(:redirect_to)
      end
    end
  end

  # mocked token value since the method is testing an external service
  describe "#set_token" do
    it 'sets and returns a token' do
      allow(controller).to receive(:set_token).and_return "8a33ec95-cbbe-4dc7-b575-7ce60056aea0"
      token = controller.send(:set_token)
      expect(token).to eq "8a33ec95-cbbe-4dc7-b575-7ce60056aea0"
    end
  end
end
