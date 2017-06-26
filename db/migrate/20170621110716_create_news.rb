class CreateNews < ActiveRecord::Migration[5.0]
  def change
    create_table :news do |t|
      t.string :title
      t.text :brief
      t.text :text

      t.timestamps
    end
  end
end
