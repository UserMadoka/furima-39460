class CreateShippings < ActiveRecord::Migration[7.0]
  def change
    create_table :shippings do |t|
      t.string     :postal_code,   null: false
      t.string     :city,          null: false
      t.string     :addresses,     null: false
      t.string     :building,      null: true
      t.string     :phone_number,  null: false
      t.integer    :prefecture_id, null: false
      t.references :user,          null: false, foreign_key: true
      t.references :order,         null: false, foreign_key: true
      t.timestamps
    end
  end
end
