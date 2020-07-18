class CreatePackages < ActiveRecord::Migration[6.0]
  def change
    create_table :packages do |t|
      t.integer :quantity
      t.integer :price
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
