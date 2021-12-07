# テーブル設計

## usersテーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| first_name         | string  | null: false               |
| last_name          | string  | null: false               |
| first_name_kana    | string  | null: false               |
| last_name_kana     | string  | null: false               |
| birthday           | date    | null: false               |

### association

- has_many :items
- has_many :purchases

## itemsテーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| name             | string     | null: false                    |
| description      | text       | null: false                    |
| price            | integer    | null: false                    |
| category_id      | integer    | null: false                    |
| state_id         | integer    | null: false                    |
| shipping_cost_id | integer    | null: false                    |
| prefecture_id    | integer    | null: false                    |
| shipping_day_id  | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |

### association

- belongs_to :user
- has_one :purchase
- has_many :tags, through :item_tag_relations
- has_many :item_tag_relations

## tagsテーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| tag_name | string     | null: false,                   |
| item     | references | null: false, foreign_key: true |

### association

- has_many :items, through :item_tag_relations
- has_many :item_tag_relations

## item_tag_relationsテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| item   | references | null: false, foreign_key: true |
| tag    | references | null: false, foreign_key: true |

### association

- belongs_to :item
- belongs_to :tag

## deliveriesテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| post_num      | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| address       | string     | null: false                    |
| building      | string     |                                |
| phone         | string     | null: false                    |
| purchase      | references | null: false, foreign_key: true |

- belongs_to :purchase

## purchasesテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| item   | references | null: false, foreign_key: true |
| user   | references | null: false, foreign_key: true |

### association

- belongs_to :item
- belongs_to :user
- has_one :delivery