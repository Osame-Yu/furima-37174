class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image
  belongs_to :category
  belongs_to :state
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :shipping_day
  has_one :purchase
  has_many :item_tag_relations
  has_many :tags, through: :item_tag_relations
end
