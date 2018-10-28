class AddPriceToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :price_in_cents, :integer
  end
end
