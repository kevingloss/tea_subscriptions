class ChangeTeaPricetoInteger < ActiveRecord::Migration[5.2]
  def change
    change_column :tea_subscriptions, :tea_price, :integer
  end
end
