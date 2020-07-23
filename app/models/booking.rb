class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :lesson

  validates :quantity, presence: true

  
end
