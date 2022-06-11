class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  def new
    @cart_items = CartItem.new
  end

  def index
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  def create
    # 追加した商品がカート内に存在するかの判別
    #@cart_item = CartItem.find_by(item_id:1)
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id

    @cart_item.save!
    #binding.pry
    redirect_to cart_items_path
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end


  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
end
