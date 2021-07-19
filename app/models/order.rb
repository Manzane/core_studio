class Order < ApplicationRecord
  belongs_to :user
  belongs_to :cart
  monetize :amount_cents
  enum status: [ :waiting, :paid, :cancelled , :refunded]

  validates :date, :state, :amount, :status, presence: true
  scope :ordered, -> { order("date").reverse_order }

end
