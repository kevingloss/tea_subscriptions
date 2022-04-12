class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.float :price
      t.integer :status, default: 0
      t.integer :frequency, default: 0
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
