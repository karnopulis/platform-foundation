class AddTypeToPrice < ActiveRecord::Migration[5.0]
  def change
    add_column :prices, :name, :string
  end
end
