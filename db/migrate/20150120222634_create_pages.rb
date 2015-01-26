class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :seo_title
      t.string :seo_desc
      t.integer :status
      t.text :content
      t.integer :content_type
      t.integer :position
      t.string :slug
      t.string :parentals
      t.string :ancestry
      t.string :image
      t.string :template
      t.integer :client_id

      t.timestamps null: false
    end
  end
end
