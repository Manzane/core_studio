class RemoveAgendaReferencesFromBookings < ActiveRecord::Migration[6.0]
  def change
    remove_reference :bookings, :agenda, null: false, foreign_key: true
  end
end
