class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :name
      t.string :location
      t.string :description
      t.integer :capacity
      t.integer :price
      t.string :image
      t.date :date

      t.timestamps
    end
  end
end
