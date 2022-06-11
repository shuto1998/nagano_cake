class CartItem < ApplicationRecord
  belongs_to:item
  belongs_to:customer
  # belongs_to:order

  def sum_of_price
    item.add_tax_price * amount
  end

end
