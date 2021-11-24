# テーブル設計

## usersテーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| first_name         | string | null: false               |
| last_name          | string | null: false               |
| first_name_kana    | string | null: false               |
| last_name_kana     | string | null: false               |

### association

- has_many :items
- belongs_to :purchaser

## itemsテーブル

| Column        | Type    | Options     |
| ------------- | ------- | ----------- |
| name          | string  | null: false |
| description   | text    | null: false |
| category      | string  | null: false |
| state         | string  | null: false |
| price         | integer | null: false |
| shipping_cost | string  | null: false |
| prefecture    | string  | null: false |
| shipping_days | string  | null: false |
| sold          | integer | null: false |

### association

- belongs_to :user
- belongs_to :purchaser

## purchaserテーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| post_num   | integer    | null: false                    |
| prefecture | string     | null: false                    |
| city       | string     | null: false                    |
| address    | string     | null: false                    |
| building   | string     |                                |
| phone      | integer    | null: false                    |
| user_id    | references | null: false, foreign_key: true |
| item_id    | references | null: false, foreign_key: true |

- belongs_to :user
- belongs_to :item
