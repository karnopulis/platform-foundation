class CreateProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :properties do |t|
      t.string :title
      t.string :permalink
      t.integer :position

      t.timestamps
    end
  end
end
