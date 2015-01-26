class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :title
      t.string :file
      t.integer :position
      t.integer :status
      t.string :source_url
      t.integer :upload_type
      t.integer :client_id

      t.timestamps null: false
    end
  end
end
