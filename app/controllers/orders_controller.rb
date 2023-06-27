class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order_shipping = OrderShipping.new
  end
end
