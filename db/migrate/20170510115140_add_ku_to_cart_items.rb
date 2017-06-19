class AddKuToCartItems < ActiveRecord::Migration[5.0]
  def change
    add_column :cart_items, :ku, :integer
  end
end
