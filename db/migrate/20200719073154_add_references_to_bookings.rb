class AddReferencesToBookings < ActiveRecord::Migration[6.0]
  def change
    add_reference :bookings, :lesson, null: false, foreign_key: true
  end
end
