class PurchaseDelivery

  include ActiveModel:: Modele
  attr_accesser :item, :user_id
                :post_num, :prefecture_id, :city, :address, :building, :phone, :purchase_id,

  with_options presence: true do
    validates :item
    validates :user_id
    validates :post_num, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'must include both numbers and hyphen(-)' }
    validates :city
    validates :address
    validates :phone, numericality: { only_integer: true, message: 'must be numbers' }
    validates :purchase_id
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    purchase = Purchase.create(item: item, user_id: user_id)
    Delivery.create(post_num: post_num, city: city, address: address, phone: phone, purchase_id: purchase_id)
  end
end