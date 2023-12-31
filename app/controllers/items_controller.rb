class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :access_correct, only: [:edit]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    return unless @item.purchase_record.present?

    redirect_to root_path
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    return unless @item.destroy

    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:item_image, :item_name, :description, :category_id, :condition_id, :fee_option_id, :region_id,
                                 :delivery_d_id, :price).merge(user_id: current_user.id)
  end

  def access_correct
    return if @item.user.id == current_user.id

    redirect_to root_path
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
