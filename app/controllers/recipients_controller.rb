class RecipientsController < ApplicationController
  before_action :auth

  def index
    @recipients = Recipient.all
  end

  def new
    @recipient = Recipient.new
  end

  def create
    create_params = recipient_params.merge(recipient_id: recipient_id)
    @recipient = current_user.recipients.new create_params
    if @recipient.save
      redirect_to recipients_path
    else
      flash.now[:alert] = "ERROR: #{@recipient.errors.full_messages}"
      render :new
    end
  end

  private

  def recipient_params
    params.require(:recipient).permit(:name)
  end

  def recipient_id
    JSON.parse(request_recipient)['recipient']['id']
  end

  def request_recipient
    RestClient.post recipient_url, set_recipient_values , set_recipient_header
  end

  def set_recipient_header
    {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{@token}"
    }
  end

  def set_recipient_values
    '{"recipient": {"name": "' + recipient_params[:name] + '"} }'
  end

  def recipient_url
    "#{Testapp::Application.config.coolpay_base_url}/recipients"
  end
end
