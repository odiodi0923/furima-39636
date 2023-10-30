class PurchaseRecordsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_purchase_record, only: [:index, :create]
  before_action :purchase_access, only: [:index]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @purchase_info = PurchaseInfo.new
    return unless @item.purchase_record.present?

    redirect_to root_path
  end

  def create
    @purchase_info = PurchaseInfo.new(record_params)
    if @purchase_info.valid?
      pay_item
      @purchase_info.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def record_params
    params.require(:purchase_info).permit(:postal_code, :region_id, :city, :street_num, :building, :phone, :purchase_record).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    @item = Item.find(params[:item_id])
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency: 'jpy'
    )
  end

  def purchase_access
    return unless @item.user.id == current_user.id

    redirect_to root_path
  end

  def set_purchase_record
    @item = Item.find(params[:item_id])
  end
end
