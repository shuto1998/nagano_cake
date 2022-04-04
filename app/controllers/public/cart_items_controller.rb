class Public::CartItemsController < ApplicationController
  def new
    @cart_items = CartItem.new
  end

  def index
    @cart_items = current_customer.cart_items
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    # binding.pry
    @cart_item.save
    redirect_to  public_cart_items_path
  end


   private
  def cart_item_params
      params.require(:cart_item).permit(:item_id,:amount)
  end
end
