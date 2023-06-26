class OrderShipping
  include ActiveModel::Model
  attr_accessor :price, :user_id, :item_id, :postal_code, :city, :addresses, :building, :phone_number, :prefecture_id, :order_id

  validates :price,      presence: true
  validates :user_id, presence: true
  validates :item_id, presence: true
  validates :postal_code, presence: true
  validates :city, presence: true
  validates :addresses, presence: true
  validates :phone_number, presence: true
  validates :prefecture_id, presence: true
  validates :order_id, presence: true
end