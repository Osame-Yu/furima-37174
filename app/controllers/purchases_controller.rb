class PurchasesController < ApplicationController

  def index
    @purchase_delivery = PurchaseDelivery.new
  end

  def create
    @purchase_delivery = PurchaseDelivery.new(purchase_params)
  end

  private
  def purchase_params
    require(:purchase_delivery).permit(:post_num, :prefecture, :city, :address, :building, :phone).
                                merge(user_id: current_user.id, item_id: parame[:item_id])
end
