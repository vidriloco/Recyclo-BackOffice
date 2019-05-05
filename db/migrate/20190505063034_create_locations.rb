class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.text    :place_identifier
      t.integer :user_id, null: false
      t.float   :lat, null: false
      t.float   :lng, null: false
      t.text    :address, null: false
      t.string  :zone, null: false

      t.timestamps
    end
  end
end
