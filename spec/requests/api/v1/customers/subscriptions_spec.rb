require 'rails_helper'

RSpec.describe "Subscriptions", type: :request do
  describe "GET /index" do
    it 'lists out all active/canceled subscriptions' do 
      customer = create(:customer)
      sub_1 = create(:subscription, status: 0, customer: customer)
      create_list(:tea_subscription, 2, subscription: sub_1)
      sub_2 = create(:subscription, status: 1, customer: customer)
      create_list(:tea_subscription, 2, subscription: sub_2)

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

    it 'throws an error when customer does not exist' do 
      headers = { 'CONTENT_TYPE' => 'application/json' }
      get api_v1_customer_subscriptions_path(0), headers: headers

      message = parse_json[:message]

      expect(response.status).to eq(404)
      expect(message).to eq('Customer does not exist.')
    end
  end

  describe "POST /create" do
    it 'create a new subscription for a customer' do 
      customer = create(:customer)
      t1 = create(:tea)
      t2 = create(:tea)
      t3 = create(:tea)

      headers = { 'CONTENT_TYPE' => 'application/json' }
      body = {
        order: [{tea_id: t1.id, qty: 40}, {tea_id: t2.id, qty: 80}, {tea_id: t3.id, qty: 16}]
      }

      post api_v1_customer_subscriptions_path(customer), headers: headers, params: JSON.generate(body)

      data = parse_json[:data]

      expect(response.status).to eq(201)
      expect(data[:attributes][:status]).to eq('active')
      expect(data[:attributes][:frequency]).to eq('monthly')
      expect(data[:attributes][:total_price]).to be_a(Integer)
      expect(data[:attributes][:teas]).to be_a(Array)
    end

    it 'creates a pending subscription for a customer' do 
      customer = create(:customer)

      headers = { 'CONTENT_TYPE' => 'application/json' }
      body = {
      }

      post api_v1_customer_subscriptions_path(customer), headers: headers, params: JSON.generate(body)

      data = parse_json[:data]

      expect(response.status).to eq(201)
      expect(data[:attributes][:status]).to eq('pending')
      expect(data[:attributes][:frequency]).to eq('monthly')
      expect(data[:attributes][:total_price]).to be_a(Integer)
      expect(data[:attributes][:teas]).to be_a(Array)
    end
  end

  describe "PATCH /update" do
    it 'update the status to cancelled' do 
      customer = create(:customer)
      t1 = create(:tea)
      t2 = create(:tea)
      t3 = create(:tea)

      headers = { 'CONTENT_TYPE' => 'application/json' }
      body = {
        order: [{tea_id: t1.id, qty: 40}, {tea_id: t2.id, qty: 80}, {tea_id: t3.id, qty: 16}]
      }
      
      post api_v1_customer_subscriptions_path(customer), headers: headers, params: JSON.generate(body)

      data = parse_json[:data]

      expect(data[:attributes][:status]).to eq('active')
      expect(data[:attributes][:frequency]).to eq('monthly')

      params = {
        status: 'cancelled',
        frequency: 'weekly'
      }

      patch api_v1_customer_subscription_path(customer, Subscription.last), headers: headers, params: JSON.generate(params)
      
      data = parse_json[:data]

      expect(response.status).to eq(200)
      expect(data[:attributes][:status]).to eq('cancelled')
      expect(data[:attributes][:frequency]).to eq('weekly')
    end

    it 'throw an error if the subscription does not update' do 
      customer = create(:customer)
      t1 = create(:tea)
      t2 = create(:tea)
      t3 = create(:tea)

      headers = { 'CONTENT_TYPE' => 'application/json' }
      body = {
        order: [{tea_id: t1.id, qty: 40}, {tea_id: t2.id, qty: 80}, {tea_id: t3.id, qty: 16}]
      }
      params = {
        status: 'more tea please',
        stuff: 'coffee please'
      }

      post api_v1_customer_subscriptions_path(customer), headers: headers, params: JSON.generate(body)

      patch api_v1_customer_subscription_path(customer, Subscription.last), headers: headers, params: JSON.generate(params)
      
      message = parse_json[:message]

      expect(response.status).to eq(400)
      expect(message).to eq('Error please check status/frequency input.')
    end

    it 'throw an error if the subscription does not exist' do 
      customer = create(:customer)
      t1 = create(:tea)
      t2 = create(:tea)
      t3 = create(:tea)

      headers = { 'CONTENT_TYPE' => 'application/json' }
      body = {
        order: [{tea_id: t1.id, qty: 40}, {tea_id: t2.id, qty: 80}, {tea_id: t3.id, qty: 16}]
      }
      params = {
        status: 'cancelled'
      }

      post api_v1_customer_subscriptions_path(customer), headers: headers, params: JSON.generate(body)

      patch api_v1_customer_subscription_path(customer, 0), headers: headers, params: JSON.generate(params)
      
      message = parse_json[:message]

      expect(response.status).to eq(404)
      expect(message).to eq('Subscription does not exist.')
    end
  end
end
