class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.datetime :date
      t.integer :amount
      t.string :state
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
