class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  

  def complete
  end

  def index
    
  end

  def show
  end
  
  def comfirm
    @order = Order.new(order_params)
    # current_customer => cart_items => items
    @items = current_customer.items
    if params[:order][:address] == "0"
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.name
    elsif params[:order][:address] == "1"
      @order.postal_code = Address.find(params[:order][:address_id]).postal_code
      @order.address = Address.find(params[:order][:address_id]).address
      @order.name = Address.find(params[:order][:address_id]).name
    elsif params[:order][:address] == "2"
      @new_address = Address.new
      @new_address.postal_code = params[:order][:postal_code]
      @new_address.address = params[:order][:address]
      @new_address.name = params[:order][:name]
      @new_address.customer_id = current_customer.id
      if @new_address.save
        @order.postal_code = @new_address.postal_code
        @order.address = @new_address.address
        @order.name =@new_address.name
      else
        render :new
      end
    end
    # @cart_items = CartItem.where(customer_id: current_customer.id)
    @cart_items = current_customer.cart_items
    @total = 0
    @shipping_cost = 800
  end
  
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    @order_details = OrderDetail.new
    @cart_items = current_customer.cart_items
    @order_details.item_id = @cart_item.item_id
    @order_details.amount = @cart_item.amount
    @order_details.price = @cart_item.item.add_tax_price
    @order_details.save
    current_customer.cart_items.destroy_all
    redirect_to complete_public_orders_path
  end
  
  private
  
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :total_payment, :payment_method, :shipping_cost, :status)
  end
end
