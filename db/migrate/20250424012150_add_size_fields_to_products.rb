class AddSizeFieldsToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :stock_pp, :integer
    add_column :products, :stock_p, :integer
    add_column :products, :stock_m, :integer
    add_column :products, :stock_g, :integer
    add_column :products, :stock_gg, :integer
    add_column :products, :size, :integer
    add_column :products, :color, :string
  end
end
