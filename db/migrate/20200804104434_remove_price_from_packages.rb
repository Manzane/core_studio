class RemovePriceFromPackages < ActiveRecord::Migration[6.0]
  def change
    remove_column :packages, :price, :integer
  end
end
