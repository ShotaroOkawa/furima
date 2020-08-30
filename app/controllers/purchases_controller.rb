class PurchasesController < ApplicationController
  before_action :move_to_index, only: %i[index create]
  before_action :move_to_index2, only: %i[index create]

  def index
    @purchase_address = PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_address_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private

  def purchase_address_params
    params.require(:purchase_address).permit(:price, :token, :zip_code, :prefecture_id, :city, :lot_number, :building_name, :phone_number).merge(user_id: current_user.id).merge(item_id: params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: purchase_address_params[:price],
      card: purchase_address_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_index
    @item = Item.find(params[:item_id])
    if user_signed_in?
      redirect_to root_path if @item.user_id == current_user.id
    else
      redirect_to root_path
    end
  end

  def move_to_index2
    @item = Item.find(params[:item_id])
    redirect_to root_path if Purchase.exists?(item_id: @item.id)
  end
end
