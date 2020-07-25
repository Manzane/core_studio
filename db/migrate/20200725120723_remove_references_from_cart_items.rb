class RemoveReferencesFromCartItems < ActiveRecord::Migration[6.0]
  def change
    remove_reference :cart_items, :order, null: false, foreign_key: true
    add_reference :cart_items, :cart, index: true, foreign_key: true
  end
end
