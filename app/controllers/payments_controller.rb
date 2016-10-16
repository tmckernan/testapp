class PaymentsController < ApplicationController
  before_action :auth, :recipient

  def index
    @payments = recipient_payments.sort_by do |line|
      line["created_at"]
    end.reverse
  end

  def new
    @payment = Payment.new
  end

  def create
    @payment = recipient.payments.new create_params
    if @payment.save
      redirect_to recipient_payments_path(recipient.id)
    else
      flash.now[:alert] = "ERROR: #{@payment.errors.full_messages}"
      render :new
    end
  end

  private

  def recipient
    @recipient ||= Recipient.find params[:recipient_id]
  end

  def payment_params
    params.require(:payment).permit(:currency, :amount)
  end

  def set_payment_header
    {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{@token}"
    }
  end

  def set_payment_values
    {
      payment: {
        amount: payment_params[:amount],
        currency: payment_params[:currency],
        recipient_id: recipient.recipient_id
      }
    }.to_json
  end

  def payment_url
    "#{Testapp::Application.config.coolpay_base_url}/payments"
  end

  def create_params
    new_params = payment_params.merge(payment_id: payment_response[:id])
    new_params.merge(payment_response.slice!(:id))
  end

  def recipient_payments
    response = RestClient.get payment_url, set_payment_header
    json_response = JSON.parse(response)['payments'] || []
    process_payment(json_response)
  end

  def process_payment(json_respone)
    json_respone.map do |response_line|
      database_payment = check_payment_response(response_line['id'])
      if database_payment
        response_line.merge('created_at' => database_payment.created_at)
      end
    end.compact
  end

  def check_payment_response(id)
    recipient.payments.find_by(payment_id: id)
  end

  def payment_response
    response = JSON.parse(request_payment)['payment']
    response.slice!('recipient_id', 'status').symbolize_keys
  end

  def request_payment
    RestClient.post payment_url, set_payment_values, set_payment_header
  end
end
