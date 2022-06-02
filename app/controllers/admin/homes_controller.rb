class Admin::HomesController < ApplicationController
  def top
    @orders = Order.all
  end
  
  private
  
  def order_params
    params.require(:order).permit(:name, :status, :created_at)
  end
end
