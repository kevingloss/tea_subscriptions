require 'rails_helper'

RSpec.describe TeaSubscription, type: :model do
  describe 'validations' do 
    it { should validate_presence_of :tea_qty }
    it { should validate_presence_of :tea_price }
    it { should validate_numericality_of(:tea_qty).is_greater_than(0).only_integer }
    it { should validate_numericality_of(:tea_price).is_greater_than(0).only_integer }
  end

  describe 'relationships' do 
    it { should belong_to :subscription }
    it { should belong_to :tea }
  end
end
