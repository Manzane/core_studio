class Cart < ApplicationRecord
  belongs_to :user
  has_one :order
  has_many :cart_items, dependent: :destroy
end