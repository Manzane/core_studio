class Lesson < ApplicationRecord
  belongs_to :category
  belongs_to :thematic
  has_many :bookings, dependent: :destroy
  validates :name, :start_time, :end_time, presence: true

end
