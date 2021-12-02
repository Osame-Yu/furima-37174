class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :move_to_top, only: [:index, :create]

  def index
    item_find
    @purchase_delivery = PurchaseDelivery.new
  end

  def create
    @purchase_delivery = PurchaseDelivery.new(purchase_params)
    if @purchase_delivery.valid?
      pay_item
      @purchase_delivery.save
      redirect_to root_path
    else
      item_find
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_delivery).permit(:post_num, :prefecture_id, :city, :address, :building, :phone)
          .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    item = Item.find(params[:item_id])
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_top
    item_find
    @user = @item.user
    redirect_to root_path if current_user.id == @user.id || Purchase.exists?(item_id: @item.id)
  end

  def item_find
    @item = Item.find(params[:item_id])
  end
end
