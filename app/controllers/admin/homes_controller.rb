class Admin::HomesController < ApplicationController
  def top
    @orders = Order.all
    @total_amount = 0
  end
  
private
  
  def order_params
    params.require(:order).permit(:customer_id, :status)
  end
end