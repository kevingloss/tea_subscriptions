require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'validations' do 
    it { should validate_presence_of :status }
    it { should validate_presence_of :frequency }
  end

  describe 'relationships' do 
    it { should belong_to :customer }
    it { should have_many :tea_subscriptions }
    it { should have_many(:teas).through(:tea_subscriptions)}
  end

  describe 'methods' do 
    it 'can add tea subscriptions based on an order' do 
      customer = create(:customer)
      subscription = create(:subscription, customer: customer)
      t1 = create(:tea)
      t2 = create(:tea)
      t3 = create(:tea)
      orders = [{tea_id: t1.id, qty: 40}, {tea_id: t2.id, qty: 80}, {tea_id: t3.id, qty: 16}]
      
      subscription.place_orders(orders)

      # binding.pry
      expect(subscription.tea_subscriptions).to eq(TeaSubscription.last(3))
    end
  end
end
