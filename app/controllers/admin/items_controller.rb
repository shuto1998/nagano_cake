class Admin::ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end
  
   def create
 
    item = Item.new(item_params)
  
    item.save
  
    redirect_to admin_item_path[:id]
  end
  
  def show
  end

  def edit
  end
  def list_params
    params.require(:item).permit(:genre_id, :name,:image_id,:introduction,:price,:is_active)
  end
end
