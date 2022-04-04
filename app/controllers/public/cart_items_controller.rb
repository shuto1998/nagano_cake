class Public::CartItemsController < ApplicationController
  def new
    @cart_items = CartItem.new
  end
  
  def index
  end
  
  def create
    @cart_items = CartItem.new(cart_items_params)
    @cart_items.customer_id = current_customer.id
    @cart_items.save
    redirect_to  public_cart_items_path
  end
  
  
   private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
end
