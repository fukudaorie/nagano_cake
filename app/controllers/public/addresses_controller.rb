class Public::AddressesController < ApplicationController
  def index
    @addresses = Address.all
  end

  def edit
  end
end
