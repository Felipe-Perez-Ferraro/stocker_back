class AddBrandToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :brand, :string
  end
end
