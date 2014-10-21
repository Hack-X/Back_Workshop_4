class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :user_name
      t.integer :seats
      t.references :show, index: true

      t.timestamps
    end
  end
end
