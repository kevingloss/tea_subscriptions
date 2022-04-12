class TeaSubscription < ApplicationRecord
  belongs_to :subscription
  belongs_to :tea
  validates :tea_qty, presence: true
  validates_numericality_of :tea_qty, greater_than: 0, only_integer: true
  validates :tea_price, presence: true
  validates_numericality_of :tea_price, greater_than: 0, only_integer: true
end
