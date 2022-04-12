class Subscription < ApplicationRecord
  belongs_to :customer
  has_many :tea_subscriptions
  has_many :teas, through: :tea_subscriptions
  validates :status, presence: true
  validates :frequency, presence: true
  enum status: { active: 0, cancelled: 1 }
  enum frequency: { weekly: 0, bi_weekly: 1, monthly: 2 }
end
