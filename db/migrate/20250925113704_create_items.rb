class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.string :title
      t.string :brand
      t.string :color
      t.string :size
      t.text :description
      t.string :category
      t.string :collection
      t.string :status
      t.integer :price_cents

      t.timestamps
    end
  end
end
