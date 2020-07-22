class Lesson < ApplicationRecord
  belongs_to :category
  belongs_to :thematic
  has_many :bookings, dependent: :destroy
  validates :name, :start_time, :end_time, presence: true

  # scope :with_bookings, -> (bookingId) {where("self.bookings == ?"), bookingId}

  
  def full?
  sum = 0
  self.bookings.each do | booking |
    sum += booking.quantity
  end
  if sum < self.capacity
    return false
  else
    return true
  end
end
end
