class Lesson < ApplicationRecord
  belongs_to :category
  belongs_to :thematic
  has_many :agendas, dependent: :destroy
  validates :name, presence: true
end
