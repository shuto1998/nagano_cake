class Public::OrdersController < ApplicationController
  def show
  end

  def index
  end

  def new
    @orders = Order.all
    @order = Order.new

    # @order.postal_code = current_customer.postal_code
    # @order.address = current_customer.address
    # @order.name = current_customer.first_name + current_customer.last_name

  end

  # def create
  #   order = Order.new(order_params)
  #   order.save
  #   redirect_to comfirm_orders_path
  # end

  def comfirm
     #カートアイテムの定義
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }

    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
          @order.postal_code = current_customer.postal_code
          @order.address = current_customer.address
          @order.name = current_customer.first_name + current_customer.last_name

    elsif  params[:order][:select_address] == "1"
         @address = Address.find(params[:order][:address_id])
         @order.postal_code = @address.postal_code
         @order.address = @address.address
         @order.name = @address.name


    elsif  params[:order][:select_address] == "2"


    end
    # @order = Order.new(order_params)
    # @order.postal_code = current_customer.postal_code
    # @order.address = current_customer.address
    # @order.name = current_customer.first_name + current_customer.last_name
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:customer_id,:postal_code,:address,:name,:shipping_cost,:total_payment,:status,:payment_method)
  end

end
