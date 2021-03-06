class Customer < ApplicationRecord
  has_many :subscriptions
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates_address fields: [:street, :street2, :city, :state, :postal_code]

  def not_pending_subscriptions
    subscriptions.where.not(status: 'pending').order(created_at: :desc)
  end
end
