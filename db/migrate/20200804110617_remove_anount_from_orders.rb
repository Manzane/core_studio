class RemoveAnountFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :amount, :integer
  end
end
