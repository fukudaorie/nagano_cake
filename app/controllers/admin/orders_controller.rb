class Admin::OrdersController < ApplicationController
  def show
  end
  
  private
  
  def order_params
    params.require(:order).permit(:name, :status, :created_at)
  end
end
