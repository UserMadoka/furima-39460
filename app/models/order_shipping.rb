class OrderShipping
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :city, :addresses, :building, :phone_number, :prefecture_id,
                :token

  # 必須のチェック
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code
    validates :city
    validates :addresses
    validates :phone_number
    validates :token
  end

  # 都道府県
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
  # 郵便番号
  validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
  # 電話番号
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number' }

  def save
    order = Order.create(user_id:, item_id:)
    Shipping.create(postal_code:, city:, addresses:, building:, phone_number:,
                    prefecture_id:, order_id: order.id)
  end
end
