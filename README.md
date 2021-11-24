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
| birth_y            | integer | null: false               |
| birth_m            | integer | null: false               |
| birth_d            | integer | null: false               |

### association

- has_many :items
- belongs_to :purchaser

## itemsテーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| name             | string     | null: false                    |
| description      | text       | null: false                    |
| price            | integer    | null: false                    |
| category_id      | string     | null: false                    |
| state_id         | string     | null: false                    |
| shipping_cost_id | string     | null: false                    |
| prefecture_id    | string     | null: false                    |
| shipping_day_id  | string     | null: false                    |
| user_id          | references | null: false, foreign_key: true |

### association

- belongs_to :user
- has_one :purchase

## deliveryテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| post_num      | string     | null: false                    |
| prefecture_id | string     | null: false                    |
| city          | string     | null: false                    |
| address       | string     | null: false                    |
| building      | string     |                                |
| phone         | string     | null: false                    |
| user_id       | references | null: false, foreign_key: true |
| item_id       | references | null: false, foreign_key: true |

- belongs_to :user
- belongs_to :purchase

## purchaseテーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| item_id     | references | null: false, foreign_key: true |
| delivery_id | references | null: false, foreign_key: true |

### association

- belongs_to :item
- belongs_to :delivery