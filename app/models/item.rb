class Item < ApplicationRecord
  has_one :purchase_record
  belongs_to :user
end
