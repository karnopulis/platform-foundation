class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.boolean :hidden
      t.float :sort_weight
      t.string :title
      t.string :permalink

      t.timestamps
    end
  end
end
