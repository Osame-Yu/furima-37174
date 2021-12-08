class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :move_to_index, only: [:edit, :update]
  before_action :item_find, only: [:show, :edit, :update]
  before_action :purchase_all, only: [:index, :show]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item_form = ItemForm.new
  end

  def create
    @item_form = ItemForm.new(item_form_params)
    if @item_form.valid?
      @item_form.save
      redirect_to root_path
    else
      render new_item_path
    end
  end

  def show
  end

  def edit
    item_attributes = @item.attributes
    @item_form = ItemForm.new(item_attributes)
    @item_form.tag_name = @item.tags&.first&.tag_name
  end

  def update
    @item_form = ItemForm.new(item_form_params)
    @item_form.image ||= @item.image.blob
    if @item_form.valid?
      @item_form.update(item_form_params, @item)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to root_path
  end

  def search
    return nil if params[:keyword] == ""
    tag = Tag.where(['tag_name. LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end
  
  private

  def item_form_params
    params.require(:item_form).permit(:name, :description, :price, :category_id, :state_id, :shipping_cost_id, :prefecture_id,
                                 :shipping_day_id, :image, :tag_name).merge(user_id: current_user.id)
  end

  def move_to_index
    @item = Item.find(params[:id])
    @user = @item.user
    redirect_to root_path if current_user.id != @user.id || Purchase.exists?(item_id: @item.id)
  end

  def item_find
    @item = Item.find(params[:id])
  end

  def purchase_all
    @purchase = Purchase.all
  end
end
