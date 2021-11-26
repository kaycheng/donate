class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @order = current_user.orders.new
  end

  def create
    @order = current_user.orders.new(order_params)
    if @order.save
      # do something
      redirect_to root_path, notice: "Thank you for donating!"
    else
      # do something
      render :new, flash_now: "There are some errors occured!"
    end
  end

  private
  def order_params
    params.require(:order).permit(:username, :amount, :memo, :pay_type)
  end
end