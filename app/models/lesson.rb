class Lesson < ApplicationRecord
  belongs_to :category
  belongs_to :thematic
  validates :name, presence: true
end
