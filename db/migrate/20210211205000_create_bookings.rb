class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :flat, null: false, foreign_key: true
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :status
      t.integer :price
      t.text :client_message

      t.timestamps
    end
  end
end
