class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :buyer_id
      t.integer :seller_id
      t.string :buy_currency
      t.float :buy_amount
      t.string :sell_currency
      t.float :sell_amount

      t.timestamps
    end
  end
end
