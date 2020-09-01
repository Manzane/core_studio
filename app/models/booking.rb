class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :lesson

  validates :quantity, presence: true

  scope :future, -> { joins(:lesson).where("lessons.start_time > ?", Time.now).order("lessons.start_time") }
  scope :past, -> { joins(:lesson).where("lessons.start_time < ?", Time.now).order("lessons.start_time").reverse_order }
end
