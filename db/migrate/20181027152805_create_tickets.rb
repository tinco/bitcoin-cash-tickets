class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.string :address
      t.string :status
      t.json :user_info

      t.timestamps
    end
  end
end
