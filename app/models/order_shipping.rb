class OrderShipping
  include ActiveModel::Model
  attr_accessor :price, :user_id, :item_id, :postal_code, :city, :addresses, :building, :phone_number, :prefecture_id, :order_id

  # 必須のチェック
  with_options presence: true do
      validates :user_id
      validates :item_id
      validates :city
      validates :addresses
  end

  # 都道府県
  validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"}
  # 郵便番号
  validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  # 電話番号
  validates :phone_number, format: {with: /\A\d{10,11}\z/, message: "is invalid. 数字だけで入力してください"}

  def save
    order = Order.create(price: price, user_id: user_id, item_id: item_id)
    Shipping.create(postal_code: postal_code, city: city, addresses: addresses, building: building, phone_number: phone_number, prefecture_id: prefecture_id, user_id: user_id, order_id: order.id)
  end
end