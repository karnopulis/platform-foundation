class AddTotalToCart < ActiveRecord::Migration[5.0]
  def change
    add_column :carts, :total, :integer
    add_column :carts, :total_price, :float
  end
end
