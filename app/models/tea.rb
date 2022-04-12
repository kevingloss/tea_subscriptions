class Tea < ApplicationRecord
  has_many :tea_subscriptions
  has_many :subscriptions, through: :tea_subscriptions
  validates :title, presence: true
  validates :description, presence: true
  validates :temperature, presence: true
  validates_numericality_of :temperature, greater_than: 0
  validates_numericality_of :temperature, less_than_or_equal_to: 300
  validates :brew_time, presence: true
  validates_numericality_of :brew_time, greater_than: 0, only_integer: true
  validates_numericality_of :brew_time, less_than_or_equal_to: 600, only_integer: true
  validates :price, presence: true
  validates_numericality_of :price, greater_than: 0, only_integer: true
end
