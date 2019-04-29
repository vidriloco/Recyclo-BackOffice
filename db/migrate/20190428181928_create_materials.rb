class CreateMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :materials do |t|
      t.string :value, null: false
      t.boolean :enabled, default: true

      t.timestamps
    end
  end
end
