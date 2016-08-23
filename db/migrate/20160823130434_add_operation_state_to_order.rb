class AddOperationStateToOrder < ActiveRecord::Migration
  def change
    add_reference :orders, :operation_state, index: true, foreign_key: true
  end
end
