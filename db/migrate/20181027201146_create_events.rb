class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.timestamps
    end

    add_reference :tickets, :event, foreign_key: true
  end
end
