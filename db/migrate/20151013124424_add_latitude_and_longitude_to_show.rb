class AddLatitudeAndLongitudeToShow < ActiveRecord::Migration
  def change
    add_column :shows, :lat, :float
    add_column :shows, :lng, :float
  end
end
