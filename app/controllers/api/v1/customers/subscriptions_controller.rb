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
