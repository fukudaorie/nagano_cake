class Admin::HomesController < ApplicationController
  def top
    @ordesr = Order.all
  end
end
