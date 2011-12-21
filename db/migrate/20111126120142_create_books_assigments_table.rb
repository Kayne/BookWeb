class CreateBooksAssigmentsTable < ActiveRecord::Migration
  def change
    create_table(:booksassigments) do |t|
      t.integer :book_id, :null => false
      t.integer :user_id, :null => false
    end
  end
end
