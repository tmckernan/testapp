require 'webmock/rspec'
require 'factory_girl_rails'
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before(:each) do
    url = Testapp::Application.config.coolpay_base_url
    recipient = {
      recipient: {
        id: "e9a0336b-d81d-4009-9ad1-8fa1eb43418c",
        name: "Ken Bone"
      }
    }.to_json
    stub_request(:post, "#{url}/recipients").to_return(body: recipient)

    payment = {
      payment: {
        id: "31db334f-9ac0-42cb-804b-09b2f899d4d2",
        amount: 10.5,
        currency: "GBP",
        recipient_id: "6e7b146e-5957-11e6-8b77-86f30ca893d3",
        status: "processing"
      }
    }.to_json

    stub_request(:get, "#{url}/payments").to_return(status: 200, body: "{}")
    stub_request(:post, "#{url}/payments").to_return(body: payment)

  end

  config.after(:suite) do
    WebMock.allow_net_connect!
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
