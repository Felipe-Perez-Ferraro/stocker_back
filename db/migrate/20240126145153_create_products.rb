class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :sku
      t.string :name, null: false
      t.string :category, null: false
      t.string :label
      t.integer :quantity, null: false, default: 1
      t.float :price, null: false

      t.timestamps
    end
  end
end
