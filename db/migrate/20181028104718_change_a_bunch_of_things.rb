class ChangeABunchOfThings < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :price_in_cents
    add_column :events, :price, :float # lol
    add_column :tickets, :amount, :integer
    add_column :tickets, :price, :integer # lol
  end
end
