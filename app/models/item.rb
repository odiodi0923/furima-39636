class Item < ApplicationRecord
  has_one :purchase_record
  belongs_to :user
  has_one_attached :item_image
end
