class CreateCollections < ActiveRecord::Migration[5.0]
  def change
    create_table :collections do |t|
      t.boolean :hidden
      t.integer :parent
      t.integer :position
      t.integer :sort
      t.string :title
      t.string :permalink

      t.timestamps
    end
  end
end
