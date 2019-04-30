class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.integer :quantity, null: false
      t.string  :zone, null: false
      t.integer :material_id, null: false
      t.string  :units, null: false
      t.integer :user_id, null: false
      t.string  :status, default: Offer.states[:pending_review]
      t.text    :message

      t.timestamps
    end
  end
end
