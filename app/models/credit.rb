class Credit < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_paper_trail versions: {
    scope: -> { order("id desc") }
  }
  scope :from_published_categories, -> { joins(:category).merge(Category.published) }
end
