class UniqueIndexes < ActiveRecord::Migration[5.0]
  def change
    add_index(:images, [:product_id, :position], :unique => true)
    add_index(:collections, [:title, :parent], :unique => true)
    add_index(:prices, [:variant_id, :name], :unique => true)
    add_index(:properties, :title, :unique => true)
  end
end
