class Order < ApplicationRecord
  has_one :shipping
  belongs_to :user
  belongs_to :item
end
