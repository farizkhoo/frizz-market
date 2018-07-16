class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.string :buy_currency
      t.float :buy_amount
      t.string :sell_currency
      t.float :sell_amount
      t.integer :order_type

      t.timestamps
    end
  end
end
