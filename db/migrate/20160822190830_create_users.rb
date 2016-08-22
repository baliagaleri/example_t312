class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :rut
      t.string :name

      t.timestamps null: false
    end
  end
end
