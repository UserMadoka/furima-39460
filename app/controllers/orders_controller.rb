class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :select_item
  before_action :redirect_to_myitem
  before_action :redirect_to_soldout
  before_action :set_public_key, only: [:index, :create]

  def index
    @order_shipping = OrderShipping.new
  end

  def create
    @order_shipping = OrderShipping.new(order_params)
    if @order_shipping.valid?
      pay_item
      @order_shipping.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_shipping).permit(:postal_code, :city, :addresses, :building, :phone_number, :prefecture_id).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def select_item
    @item = Item.find(params[:item_id])
  end

  def redirect_to_soldout
    return unless current_user.id != @item.user.id && Order.exists?(item_id: @item.id)

    redirect_to root_path
  end

  def redirect_to_myitem
    return unless current_user.id == @item.user.id

    redirect_to root_path
  end

  def set_public_key
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end
end
