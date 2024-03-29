class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @cart_item = CartItem.new
    @cart_items = current_customer.cart_items
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(amount: params[:cart_item][:amount])
    redirect_to public_cart_items_path
  end
  
  def create
    @cart_item = CartItem.new(cart_item_params)
    current_cart_items = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    if current_cart_items.present?
      cart_item = CartItem.find_by(item_id: @cart_item.item_id, customer_id: current_customer.id)
      cart_item.update(amount: cart_item.amount + @cart_item.amount)
      redirect_to public_cart_items_path
    else
      @cart_item.save
      @cart_items = current_customer.cart_items
      render :index
    end
  end
  
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to public_cart_items_path
  end
  
  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to public_cart_items_path
  end
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end
