class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :status, :frequency

  attribute :total_price do |object|
    object.tea_subscriptions.sum("tea_qty * tea_price")
  end

  attribute :teas do |object|
    object.teas
  end
end
