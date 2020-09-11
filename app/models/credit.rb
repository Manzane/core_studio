class Credit < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_paper_trail
end
