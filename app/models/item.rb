class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :name, presence: true
  validates :desdription, presence: true
  validates :price, presence: true
  validates :category_id, presence: true
  validates :state_id, presence: true
  validates :shipping_cost_id, presence: true
  validates :prefecture_id, presence: true
  validates :shipping_id, presence: true
end
