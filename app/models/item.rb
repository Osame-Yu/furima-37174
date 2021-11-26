class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image
  belongs_to :category
  belongs_to :state
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :shipping_day

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, format: { with: /\A[\d]+\z/, message: 'must be numbers'}
  validates_inclusion_of :price, in:300..9999999, message: "is out of setting range"
  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :state_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipping_cost_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipping_day_id, numericality: { other_than: 1 , message: "can't be blank"}
end
