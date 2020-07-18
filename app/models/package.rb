class Package < ApplicationRecord
  belongs_to :category
  has_many :cart_items, dependent: :destroy
  
  validates :quantity, :price, presence: true
end
