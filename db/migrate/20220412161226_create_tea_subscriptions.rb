class CreateTeaSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :tea_subscriptions do |t|
      t.references :subscription, foreign_key: true
      t.references :tea, foreign_key: true
      t.integer :tea_qty
      t.float :tea_price

      t.timestamps
    end
  end
end
