class CreateEnquiries < ActiveRecord::Migration
  def change
    create_table :enquiries do |t|
      t.string :username
      t.string :business_name
      t.string :contact_phone
      t.string :email
      t.string :website
      t.string :abn
      t.string :comments
      t.string :tried_products
      t.string :url
      t.string :src

      t.timestamps null: false
    end
  end
end
