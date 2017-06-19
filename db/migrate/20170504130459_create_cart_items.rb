class CreateCartItems < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_items do |t|
      t.references :variant, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
