class Package < ApplicationRecord
  belongs_to :category
  has_many :cart_items, dependent: :destroy
  monetize :price_cents
  has_one_attached :image
  
  validates :quantity, presence: true
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
  
  scope :from_published_categories, -> { joins(:category).merge(Category.published) }
end
