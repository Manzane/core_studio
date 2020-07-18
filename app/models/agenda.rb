class Agenda < ApplicationRecord
  has_many :bookings
  belongs_to :lesson

  validates :time, :capacity, presence: true

  def full?
  end
end
