class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genres
  belongs_to :cart_items
  
def  add_tax_price
  (self.price * 1.10).round
end
end
