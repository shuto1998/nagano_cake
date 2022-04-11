class Public::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order.status = 0
    #@order_detailss = current_cistomer.order_details
    # @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  def index
    #@orders = Order.all
    @orders = current_customer.orders
  end
#購入情報の入力画面を作成する
  def new
    @order = Order.new
  end
#購入を確定した際に使うアクション
#Orderに情報を保存する
  def create
    cart_item = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    if @order.save
      cart_item.each do |cart_item|

      #order_detailsにもデータを保存するためのコード
      order_details = OrderDetail.new
      order_details.order_id = @order.id
      order_details.item_id = cart_item.item_id
      order_details.price = cart_item.item.price
      order_details.amount = cart_item.amount
      order_details.save
    end
    redirect_to complete_orders_path
    cart_item.destroy_all
    else
      @order = Order.new(order_params)
      render :new_cart_item_path
    end
  end

  def comfirm
     #カートアイテムの定義
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }

    @order = Order.new(order_params)


    if params[:order][:select_address] == "0"
      #@orderの住所・郵便番号・名前は現在ログインしているcustomreの物  であると定義するコード
          @order.postal_code = current_customer.postal_code
          @order.address = current_customer.address
          @order.name = current_customer.first_name + current_customer.last_name

    elsif  params[:order][:select_address] == "1"
      #登録されているaddressを探してくるコード
      #orderパラメーターからaddress_idを探してくる
         @address = Address.find(params[:order][:address_id])
      #探してきたものを@orderに定義するコード
         @order.postal_code = @address.postal_code
         @order.address = @address.address
         @order.name = @address.name


    elsif  params[:order][:select_address] == "2"

      #アドレスを新規で登録するコード
      #params に情報を入れる（今回の場合address_paramsに:postal_code,:address,:nameの情報が入っているのでその3つが登録できる）
      @address = Address.new(address_params)
      #登録したaddressの情報が誰のものか登録する。addressを登録するid=現在のaddressのid
      @address.customer_id = current_customer.id
      #作成したアドレスを保存する
      @address.save
      #作成したアドレスを@orderの変数に定義するコード
      #@orderのpostal_codeは作成した@addressのpostal_codeということを定義
      @order.postal_code = @address.postal_code
      #@orderのaddressは作成した@addressのaddressということを定義
      @order.address = @address.address
      #@orderのnameは作成した@addressのnameということを定義
      @order.name = @address.name
    end
    #shippong_costカラムは800である問いことを定義
    @order.shipping_cost = 800
    @order.status = 0
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:customer_id,:postal_code,:address,:name,:shipping_cost,:total_payment,:status,:payment_method)
  end

  def address_params
     params.require(:order).permit(:postal_code,:address,:name)
  end

end
