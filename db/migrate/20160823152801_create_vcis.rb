class CreateVcis < ActiveRecord::Migration
  def change
    create_table :vcis do |t|
      t.string :initials
      t.string :description

      t.timestamps null: false
    end
  end
end
