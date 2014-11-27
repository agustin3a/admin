class AddLonToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :lon, :float
  end
end
