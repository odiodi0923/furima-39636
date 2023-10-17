class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # 次に実装 has_one :purchase_record
  belongs_to :user
  has_one_attached :item_image

  belongs_to :category
  belongs_to :condition
  belongs_to :feeOption
  belongs_to :region
  belongs_to :delivery_d

  with_options presence: true do
    validates :item_image
    validates :item_name
    validates :description
    validates :price
  end

  validates :price,
            numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                            message: 'is out of setting range' }
  validates :price, numericality: { with: /\A[0-9]+\z/, message: 'is invalid. Input half-width characters' }

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :condition_id
    validates :fee_option_id
    validates :region_id
    validates :delivery_d_id
  end
end
