class CreateScrapes < ActiveRecord::Migration
  def change
    create_table :scrapes do |t|
      t.string :from_url
      t.string :from_id
      t.string :client_id
      t.text :content

      t.timestamps null: false
    end
  end
end
