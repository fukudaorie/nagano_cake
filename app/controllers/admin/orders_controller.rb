class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
    @shipping_cost = 800
  end
  
  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to admin_order_path(@order)
  end
  
  private
  
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :total_payment, :payment_method, :shipping_cost, :status)
  end
end
