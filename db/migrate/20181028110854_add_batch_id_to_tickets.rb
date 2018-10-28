class AddBatchIdToTickets < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :batch_id, :integer
  end
end
