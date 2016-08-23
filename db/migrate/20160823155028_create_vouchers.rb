class CreateVouchers < ActiveRecord::Migration
  def change
    create_table :vouchers do |t|
      t.references :order, index: true, foreign_key: true
      t.string :accounting_date
      t.string :buy_order
      t.string :cardnumber
      t.string :amount
      t.string :commerce_code
      t.string :authorization_code
      t.string :payment_type_code
      t.string :response_code
      t.string :transaction_date
      t.string :url_direction
      t.string :vci

      t.timestamps null: false
    end
  end
end
