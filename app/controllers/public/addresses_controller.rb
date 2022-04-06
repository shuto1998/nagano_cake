class Public::AddressesController < ApplicationController
  def new
    @address = Address.new
  end

  def create
    address = Address.new(address_params)
    address.save
    redirect_to addresses_path

  end
  def index
    @addresses = Address.all
  end

  def edit
  end

  private
  def address_params
     params.require(:address).permit(:postal_code,:address,:name,:customer_id)
  end
end
