class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.integer :position
      t.string :url
      t.string :original_url
      t.string :thumb_url
      t.string :filename
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
