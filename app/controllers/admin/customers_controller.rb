class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:id, :name, :email, :is_delete)
  end
end
