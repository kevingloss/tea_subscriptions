require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do 
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :address }
  end

  describe 'relationships' do 
    it { should have_many :subscriptions }
  end

  describe 'methods' do 
    it 'returns all subscriptions that are not pending' do 
      customer = create(:customer)
      sub_1 = create(:subscription, status: 0, customer: customer)
      create_list(:tea_subscription, 2, subscription: sub_1)
      sub_2 = create(:subscription, status: 1, customer: customer)
      create_list(:tea_subscription, 2, subscription: sub_2)
      pending = create(:subscription, status: 2, customer: customer)

      expect(customer.not_pending_subscriptions).to eq([sub_2, sub_1])
    end
  end
end
