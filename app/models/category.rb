class Category < ApplicationRecord
    has_many :lessons, dependent: :destroy
    has_many :credits
    has_many :packages, dependent: :destroy
    validates :name, presence: true
    scope :published, -> { where(published: true) }
    scope :unpublished, -> { where(published: false) }
end
