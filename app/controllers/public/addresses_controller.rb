class Public::AddressesController < ApplicationController
  def new

  end

  def create
    address = Address.new(address_params)

    address.customer_id = current_customer.id
    address.save!
    redirect_to addresses_path

  end
  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def edit
    @address = Address.find(params[:id])

  end

  def update
    address = Address.find(params[:id])
    address.update(address_params)
    redirect_to '/addresses'
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to '/addresses'
  end

  private
  def address_params
     params.require(:address).permit(:postal_code,:address,:name,:customer_id)
  end
end
