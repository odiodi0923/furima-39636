class PurchaseInfo
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :region_id, :city, :street_num, :building, :phone, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'はハイフン(-)を含めた半角文字にしてください' }
    validates :region_id, numericality: { other_than: 1, message: "を入力してください" }
    validates :city
    validates :street_num
    validates :phone, format: { with: /\A\d{10,11}\z/ }
    validates :token
  end

  def save
    purchase_record = PurchaseRecord.create(user_id:, item_id:)
    Destination.create(postal_code:, region_id:, city:, street_num:, building:,
                       phone:, purchase_record:)
  end
end
