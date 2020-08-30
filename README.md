# テーブル設計

## users テーブル

| Column           | Type    | Options      |
| ---------------- | ------- | ------------ |
| nickname         | string  | null: false  |
| email            | string  | null: false  |
| password         | string  | null: false  |
| family_name      | string  | null: false  |
| first_name       | string  | null: false  |
| family_name_kana | string  | null: false  |
| first_name_kana  | string  | null: false  |
| birthday         | date    | null: false  |

### Association

- has_many :items
- has_many :purchases


## items テーブル

| Column        | Type       | Options                        |
| ------------- | ------     | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| name          | string     | null: false                    |
| description   | string     | null: false                    |
| category_id   | integer    | null: false                    |
| condition_id  | integer    | null: false                    |
| delv_fee_id   | integer    | null: false                    |
| delv_from_id  | integer    | null: false                    |
| delv_time_id  | integer    | null: false                    |
| price         | integer    | null: false                    |

### Association

- belongs_to :user
- has_one :purchase


## purchases テーブル
| Column        | Type       | Options                        |
| ------------- | ------     | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true | 

### Association

- belongs_to :user
- belongs_to :item
- has_one :address


## addresses テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| purchase        | references | null: false, foreign_key: true |
| zip_code        | string     | null: false                    |
| prefecture_id   | integer    | null: false                    |
| city            | string     | null: false                    |
| lot_number      | string     | null: false                    |
| building_name   | string     |                                |
| phone_number    | string     | null: false                    |

### Association

- belongs_to :purchase
