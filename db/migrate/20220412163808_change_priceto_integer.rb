class ChangePricetoInteger < ActiveRecord::Migration[5.2]
  def change
    change_column :subscriptions, :price, :integer
  end
end
