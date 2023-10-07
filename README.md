# README
# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| last_name_kana     | string  | null: false               |
| first_name_kana    | string  | null: false               |
| birth_date         | date    | null: false               |


### Association

- has_many :items
- has_many :purchase_records

## items テーブル

| Column           | Type       | Options                        |
| -----------------| ------     | ------------------------------ |
| item_name        | string     | null: false                    |
| description      | text       | null: false                    |
| category_id      | integer    | null: false                    |
| condition_id     | integer    | null: false                    |
| fee_option_id    | integer    | null: false                    |
| region_id        | integer    | null: false                    |
| delivery_d_id    | integer    | null: false                    |
| price            | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |


### Association

- has_one :purchase_record
- belongs_to :user



## purchase_records テーブル

| Column          | Type       | Options                        |
| ----------------| ------     | ------------------------------ |
| user            | references | null: false, foreign_key: true |
| item            | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
- has_one :destination


## destinations テーブル

| Column          | Type       | Options                        |
| ----------------| ------     | ------------------------------ |
| postal_code     | string     | null: false                    |
| region_id       | integer    | null: false                    |
| city            | string     | null: false                    |
| street_num      | string     | null: false                    |
| building        | string     |                                |
| phone           | string     | null: false                    |
| purchase_record | references | null: false, foreign_key: true |

### Association

-belongs_to :purchase_record
