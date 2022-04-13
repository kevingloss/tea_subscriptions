class Api::V1::Customers::SubscriptionsController < ApplicationController
  before_action :find_customer, only: [:index, :create, :update]

  def index
    subscriptions = @customer.subscriptions

    if subscriptions.empty?
      render json: { message: 'You have no subscriptions currently.' }, status: :ok 
    else
      render json: SubscriptionSerializer.new(subscriptions), status: :ok
    end
  end

  def create 
    subscription = @customer.subscriptions.new(subscription_params)

    if subscription.save
      if params[:order].present?
        params[:order].each do |order|
          tea = Tea.find(order[:tea_id])
          TeaSubscription.create(tea: tea, subscription: subscription, tea_price: tea.price, tea_qty: order[:qty])
        end
      else
        subscription.pending!
      end

      render json: SubscriptionSerializer.new(subscription), status: :created 
    else
      render json: subscription.errors, status: :unprocessable_entity
    end
  end

  def update 

  end

  private
    def find_customer 
      @customer = Customer.find(params[:customer_id])
    end

    def subscription_params 
      params.permit(:status, :frequency)
    end
end
