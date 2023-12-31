class ItemsController < ApplicationController
  before_action :select_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :redirect_to_show, only: [:edit, :update, :destroy]

  def index
    @items = Item.all.order(created_at: :desc).includes(:order)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    return redirect_to root_path if @item.save

    render 'new', status: :unprocessable_entity
  end

  def show
    @soldout = Order.exists?(item_id: params[:id])
  end

  def edit
    return unless Order.exists?(item_id: params[:id])

    redirect_to root_path
  end

  def update
    return redirect_to item_path(@item) if @item.update(item_params)

    render 'edit', status: :unprocessable_entity
  end

  def destroy
    return redirect_to root_path if @item.destroy

    render 'show', status: :unprocessable_entity
  end

  private

  def item_params
    params.require(:item).permit(
      :name,
      :description,
      :price,
      :category_id,
      :condition_id,
      :shipping_charge_id,
      :shipping_date_id,
      :prefecture_id,
      :image
    ).merge(user_id: current_user.id)
  end

  def select_item
    @item = Item.find(params[:id])
  end

  def redirect_to_show
    return redirect_to root_path if current_user.id != @item.user.id
  end
end
