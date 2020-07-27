class Order < ApplicationRecord
  belongs_to :user
  belongs_to :cart


  validates :date, :state, :amount, presence: true
end
