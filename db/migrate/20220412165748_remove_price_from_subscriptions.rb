class RemovePriceFromSubscriptions < ActiveRecord::Migration[5.2]
  def change
    remove_column :subscriptions, :price
  end
end
