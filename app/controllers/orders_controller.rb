class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :select_item
  before_action :redirect_to_myitem
  before_action :redirect_to_soldout

  def index
    @order_shipping = OrderShipping.new
  end

  def create
    @order_shipping = OrderShipping.new(order_params)
    if @order_shipping.valid?
        @order_shipping.save
        redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_shipping).permit(:postal_code, :city, :addresses, :building, :phone_number, :prefecture_id).merge(user_id: current_user.id, item_id: params[:item_id], price: @item.price)
  end

  def select_item
    @item = Item.find(params[:item_id])
  end

  def redirect_to_soldout
    if current_user.id != @item.user.id && Order.exists?(item_id: @item.id) 
      return redirect_to root_path
    end
  end

  def redirect_to_myitem
    if current_user.id == @item.user.id
      return redirect_to root_path
    end
  end

end
