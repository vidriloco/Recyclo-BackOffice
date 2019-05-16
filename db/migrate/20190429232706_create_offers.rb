class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.integer :location_id, null: false
      t.integer :quantity, null: false
      t.integer :material_id, null: false
      t.string  :units, null: false
      t.integer :user_id, null: false
      t.string  :status, default: Offer.status_hash[:pending_review]
      t.text    :message

      t.timestamps
    end
  end
end
