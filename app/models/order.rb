class Order < ApplicationRecord
  belongs_to :user
  belongs_to :cart
  monetize :amount_cents

  validates :date, :state, :amount, presence: true
  scope :ordered, -> { order("date").reverse_order }

end
