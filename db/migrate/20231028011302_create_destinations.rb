class CreateDestinations < ActiveRecord::Migration[7.0]
  def change
    create_table :destinations do |t|
      t.string  :postal_code,  null: false
      t.integer :region_id,    null: false
      t.string  :city,         null: false
      t.string  :street_num,   null: false
      t.string  :building
      t.string  :phone,        null: false
      t.references :purchase_record, null: false, foreign_key: true


      t.timestamps
    end
  end
end
