class PurchaseDelivery
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :post_num, :prefecture_id, :city, :address, :building, :phone, :token

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :post_num, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'must include both numbers and hyphen(-)' }
    validates :city
    validates :address
    validates :phone, numericality: { only_integer: true, message: 'must be numbers' },
                      length: { in: 10..11 }
    validates :token
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    Delivery.create(post_num: post_num, prefecture_id: prefecture_id, city: city, address: address, phone: phone,
                    purchase_id: purchase.id)
  end
end
