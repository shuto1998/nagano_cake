class Public::ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
    @cart_items = CartItem.new
  end

  def index
    @items = Item.all
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name,:image_id,:introduction,:price,:is_active,:image)
  end
end
