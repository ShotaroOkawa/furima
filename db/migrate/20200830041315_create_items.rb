class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :user,          null: false
      t.string     :name,          null: false
      t.string     :description,   null: false
      t.integer    :category_id,   null: false
      t.integer    :condition_id,  null: false
      t.integer    :delv_fee_id,   null: false
      t.integer    :delv_from_id,  null: false
      t.integer    :delv_time_id,  null: false
      t.integer    :price,         null: false
      t.timestamps
    end
  end
end
