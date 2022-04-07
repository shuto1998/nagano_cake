class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
  has_many :cart_items
  has_many :orders
def  add_tax_price
  (self.price * 1.10).round
end
end
