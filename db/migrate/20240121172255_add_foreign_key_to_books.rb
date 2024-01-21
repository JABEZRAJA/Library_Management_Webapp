class AddForeignKeyToBooks < ActiveRecord::Migration[5.2]
  def change
    change_column :books, :user_id, :bigint

    add_foreign_key :books, :users, column: :user_id, on_delete: :cascade
  end
end
