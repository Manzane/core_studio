class Cart < ApplicationRecord
  belongs_to :user
  has_one :order
  has_many :cart_items, dependent: :destroy
  has_many :packages, through: :cart_items 
end
