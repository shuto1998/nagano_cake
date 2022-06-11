class Public::HomesController < ApplicationController
  def top
     @items = Item.page(params[:page])
  end

  def about
  end
  def index

  end
end
