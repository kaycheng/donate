class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @order = current_user.orders.new
  end

  def create
    @order = current_user.orders.new(order_params)
    if @order.save
      gateway = Sinopac::FunBiz::Gateway.new
      order = Sinopac::FunBiz::Order.new(
        order_no: @order.order_no,
        amount: @order.amount,
        product_name: 'test'
      )
      result = gateway.pay!(order: order, pay_type: :credit_card)
      if result.success?
        redirect_to result.payment_url
      else
        rediect_to root_path, notice: 'There is some errors occurred.'
      end
    else
      render :new, flash_now: "There are some errors occured!"
    end
  end

  private
  def order_params
    params.require(:order).permit(:username, :amount, :memo, :pay_type)
  end
end