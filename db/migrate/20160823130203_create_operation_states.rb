class CreateOperationStates < ActiveRecord::Migration
  def change
    create_table :operation_states do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
