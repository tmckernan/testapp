class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def auth
    current_user.account ? set_token : redirect_to(main_app.new_account_path)
  end

  private

  def set_token
    response = RestClient.post url, set_values, set_headers
    @token = JSON.parse(response)['token']
  end

  def set_headers
    { 'Content-Type' => 'application/json' }
  end

  def set_values
    username = current_user.account.username
    api_key = current_user.account.api_key
    "{\"username\": \"#{username}\", \"apikey\": \"#{api_key}\"}"
  end

  def url
    "#{Testapp::Application.config.coolpay_base_url}/login"
  end
end
