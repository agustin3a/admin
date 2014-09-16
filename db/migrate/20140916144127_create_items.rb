class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.integer :type
      t.float :price
      t.date :initial_date
      t.date :expiry_date

      t.timestamps
    end
  end
end
