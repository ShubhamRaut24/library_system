class AddTotalBooksToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :total, :int
  end
end
