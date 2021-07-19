class Thematic < ApplicationRecord
    has_many :lessons
    validates :name, presence: true
    scope :published, -> { where(published: true) }
    scope :unpublished, -> { where(published: false) }
end
