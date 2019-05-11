class CreateDonations < ActiveRecord::Migration[5.2]
  def change
    create_table :donations do |t|
      t.integer   :offer_id
      t.integer   :material_id
      t.integer   :location_id
      
      t.boolean   :is_fake
      t.string    :fake_title
      t.string    :fake_subtitle
      t.float     :fake_latitude
      t.float     :fake_longitude
      t.string    :fake_zone
      t.integer   :avatar_id

      t.timestamps
    end
  end
end
