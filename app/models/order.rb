class Order < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  validates :date, :state, :amount, presence: true
end
