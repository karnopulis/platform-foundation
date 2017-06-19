class CreateCollects < ActiveRecord::Migration[5.0]
  def change
    create_table :collects do |t|
      t.references :product, foreign_key: true
      t.references :collection, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
