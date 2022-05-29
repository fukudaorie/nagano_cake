class Public::CartItemsController < ApplicationController
  def index
    @cart_item = CartItem.new
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update
    redirect_to public_cart_items_path
  end
  
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.save
    redirect_to public_cart_items_path
  end
  
  def destroy
  end
  
  def destroy_all
  end
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end
