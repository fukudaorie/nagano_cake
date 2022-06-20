class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    if @order_detail.update(order_detail_params)
      @order.update(status: "production") if @order.order_details.exists?(making_status: "production")
      @order.update(status: "ready_to_ship") if @order.order_details.where(making_status: "production_completed").count == @order.order_details.count
    end
    redirect_to admin_order_path(@order)
  end
  
  private
  
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
