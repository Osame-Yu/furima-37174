class ItemForm
  include ActiveModel::Model

  attr_accessor :name, :description, :price, :category_id, :state_id, :shipping_cost_id, :prefecture_id, :shipping_day_id, :user_id, :image,
                :id, :created_at, :datetime, :updated_at, :datetime,
                :tag_name

  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :price, numericality: { only_integer: true, message: 'must be numbers' }
    validates :user_id
  end
  validates :price,
            numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'is out of setting range' }
  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :state_id
    validates :shipping_cost_id
    validates :prefecture_id
    validates :shipping_day_id
  end

  def save
    item = Item.create(name: name, description: description, price: price, category_id: category_id, state_id: state_id,
                       shipping_cost_id: shipping_cost_id, prefecture_id: prefecture_id, shipping_day_id: shipping_day_id,
                       user_id: user_id, image: image)
    tag = Tag.where(tag_name: tag_name).first_or_initialize
    tag.save
    ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
  end

  def update(params, item)
    item.item_tag_relations.destroy_all
    tag_name = params.delete(:tag_name)
    tag = Tag.where(tag_name: tag_name).first_or_initialize if tag_name.present?
    tag.save if tag_name.present?
    item.update(params)
    ItemTagRelation.create(item_id: item.id, tag_id: tag.id) if tag_name.present?
  end
end