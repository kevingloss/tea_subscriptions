class UpdateCustomerColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :customers, :street 
    remove_column :customers, :street2
    remove_column :customers, :city
    remove_column :customers, :state
    remove_column :customers, :postal_code
    add_column :customers, :address, :string
  end
end
