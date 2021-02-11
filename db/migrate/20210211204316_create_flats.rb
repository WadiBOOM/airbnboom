class CreateFlats < ActiveRecord::Migration[6.0]
  def change
    create_table :flats do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.integer :price
      t.string :address
      t.float :longitude
      t.float :latitude
      t.integer :capacity

      t.timestamps
    end
  end
end
