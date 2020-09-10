class Package < ApplicationRecord
  belongs_to :category
  has_many :cart_items, dependent: :destroy
  monetize :price_cents
  has_one_attached :image
  
  validates :quantity, presence: true
end
