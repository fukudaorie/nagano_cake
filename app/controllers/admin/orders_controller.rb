class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
    @shipping_cost = 800
    @order.order_details
  end
  
  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      @order.order_details.update_all(making_status: "waiting_for_production") if @order.status == "payment_confirmation"
    end
    redirect_to admin_order_path(@order)
   
  end
  
  private
  
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :total_payment, :payment_method, :shipping_cost, :status)
  end
end
