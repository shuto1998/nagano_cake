class Public::OrdersController < ApplicationController
  def show
  end

  def index
  end

  def new
    # @orders = Order.all
    @order = Order.new

    # @customer.postal_code = current_customer.postal_code
    # @customer.address = current_customer.address
    # @customer.name = current_customer.first_name + current_customer.last_name

  end

  def create
    
    order = Order.new(order_params)
    order.save
    OrderDetail.create!(
     customer_id: 1,
     order_id: 1,
  )
    cart_item.destroy_all
    redirect_to "complete_orders_path"
 
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
