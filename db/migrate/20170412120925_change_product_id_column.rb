class ChangeProductIdColumn < ActiveRecord::Migration[5.0]
  def change
    change_column_null :collects, :product_id, false
    change_column_null :collects, :collection_id, false
    change_column_null :characteristics, :property_id, false
    change_column_null :characteristics, :product_id, false
    change_column_null :images, :product_id, false
    
  end
end
