class CreateResponseCodes < ActiveRecord::Migration
  def change
    create_table :response_codes do |t|
      t.integer :value
      t.string :description

      t.timestamps null: false
    end
  end
end
