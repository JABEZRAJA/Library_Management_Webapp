class RemoveStatusfromBorrowedBook < ActiveRecord::Migration[5.2]
  def change
    remove_column :borrowed_books, :status
  end
end
