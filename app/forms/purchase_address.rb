class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :price, :token, :item_id, :zip_code, :prefecture_id, :city, :lot_number, :building_name, :phone_number, :user_id

  with_options presence: true do
    validates :zip_code
    validates :city
    validates :lot_number
    validates :phone_number
    validates :token
  end

  validates :prefecture_id, numericality: { other_than: 1, message: 'Select' }
  validates :zip_code, format: { with: /\A\d{3}\-\d{4}\z/, message: 'Input correctly' }
  validates :phone_number, format: { with: /\A\d{1,11}\z/ }

  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    Address.create(zip_code: zip_code, prefecture_id: prefecture_id, city: city, lot_number: lot_number, building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end
