class CreatePaymentTypeCodes < ActiveRecord::Migration
  def change
    create_table :payment_type_codes do |t|
      t.string :initials
      t.string :description

      t.timestamps null: false
    end
  end
end
