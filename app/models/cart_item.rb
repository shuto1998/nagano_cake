class CartItem < ApplicationRecord
  belongs_to:item
  belongs_to:customer

  def sum_of_price
    item.add_tax_price * amount
  end

end
