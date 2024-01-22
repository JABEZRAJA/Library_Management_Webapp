class AddReturnedToBorrowedBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :borrowed_books, :returned, :boolean, default: false
  end
end
