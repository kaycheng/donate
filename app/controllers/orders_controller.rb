class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = current_user.orders.new
  end
end