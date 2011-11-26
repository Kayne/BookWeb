class CreateBooksAssigmentsTable < ActiveRecord::Migration
  def change
    create_table(:booksassigments) do |t|
      t.integer :book_id
      t.integer :user_id
    end
  end
end
