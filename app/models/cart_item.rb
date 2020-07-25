class CartItem < ApplicationRecord
  belongs_to :package
  belongs_to :cart
end
