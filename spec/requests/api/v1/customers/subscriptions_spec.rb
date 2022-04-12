require 'rails_helper'

RSpec.describe "Subscriptions", type: :request do
  describe "GET /index" do
    it 'lists out all active/canceled subscriptions' do 
      customer = create(:customer)
      sub_1 = FactoryBot.create(:subscription, status: 0, customer: customer)
      FactoryBot.create_list(:tea_subscription, 2, subscription: sub_1)
      sub_2 = FactoryBot.create(:subscription, status: 1, customer: customer)
      FactoryBot.create_list(:tea_subscription, 2, subscription: sub_2)

      headers = { 'CONTENT_TYPE' => 'application/json' }
      
      get api_v1_customer_subscriptions_path(customer), headers: headers

      data = parse_json[:data]

      expect(response.status).to eq(200)
      expect(data.first.keys).to eq([:id, :type, :attributes])
      expect(data.first[:attributes].keys).to eq([:status, :frequency, :total_price, :teas])
      expect(data.first[:attributes][:teas]).to be_a(Array)
    end

    it 'customer does not have subscriptions' do 
      customer = create(:customer)
      
      headers = { 'CONTENT_TYPE' => 'application/json' }
      get api_v1_customer_subscriptions_path(customer), headers: headers

      message = parse_json[:message]

      expect(response.status).to eq(200)
      expect(message).to eq('You have no subscriptions currently.')
    end
  end
end
