class AddQuantityToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :quantity, :int
  end
end
