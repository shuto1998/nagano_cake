class Admin::CustomersController < ApplicationController
  def show
    @customers = Customer.find(params[:id])

  end

  def index
    @customers = Customer.all
  end

  def edit
    @customers = Customer.find(params[:id])
  end

  def update
    customer = Customer.find(params[:id])
    customer.update(customer_paramas)
    redirect_to admin_customer_path(customer.id)
  end

  private
  def customer_paramas
    params.require(:customer).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:postal_code,:address,:telephone_number)
  end
end
