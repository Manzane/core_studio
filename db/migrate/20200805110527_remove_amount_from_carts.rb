class RemoveAmountFromCarts < ActiveRecord::Migration[6.0]
  def change
    remove_column :carts, :amount, :integer
    add_monetize :carts, :amount, currency: { present: false }, default: 0
  end
end
