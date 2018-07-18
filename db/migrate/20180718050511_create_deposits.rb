class CreateDeposits < ActiveRecord::Migration[5.2]
  def change
    create_table :deposits do |t|
      t.references :user, foreign_key: true
      t.string :currency
      t.float :amount

      t.timestamps
    end
  end
end
