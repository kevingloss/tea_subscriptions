class Api::V1::Customers::SubscriptionsController < ApplicationController
  before_action :find_customer, only: [:index, :create]
  before_action :find_subscription, only: [:update]

  def index
    subscriptions = @customer.not_pending_subscriptions
   
    return render json: { message: 'You have no subscriptions currently.' }, status: :ok if subscriptions.empty?
    render json: SubscriptionSerializer.new(subscriptions), status: :ok
  end

  def create 
    subscription = @customer.subscriptions.new(subscription_params)

    if subscription.save
      if params[:order].present?
        subscription.place_orders(params[:order])
      else
        subscription.pending!
      end

      render json: SubscriptionSerializer.new(subscription), status: :created 
    end
  end

  def update
    begin 
      @subscription.update(subscription_params)
      render json: SubscriptionSerializer.new(@subscription), status: :ok
    rescue ArgumentError => error 
      render json: { message: error.message }, status: :bad_request
    end
  end

  private
    def find_customer 
      @customer = Customer.find(params[:customer_id])
    rescue ActiveRecord::RecordNotFound => error 
      render json: { message: 'Customer does not exist.' }, status: :not_found
    end

    def find_subscription
      @subscription = Subscription.find(params[:id])
    rescue ActiveRecord::RecordNotFound => error 
      render json: { message: 'Subscription does not exist.' }, status: :not_found
    end

    def subscription_params 
      params.permit(:status, :frequency)
    end

    def valid_status?(status)
      status == 'active' || status == 'cancelled' || status == 'pending'
    end
end
