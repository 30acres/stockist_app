class CreateStockists < ActiveRecord::Migration
  def change
    create_table :stockists do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :state
      t.string :country
      t.float :longitude
      t.float :latitude
      t.string :primary_phone
      t.string :secondary_phone
      t.string :fax
      t.text :description
      t.string :photo_file
      t.text :operating_hours
      t.string :email_address
      t.integer :status
      t.integer :position
      t.integer :client_id

      t.timestamps null: false
    end
  end
end
