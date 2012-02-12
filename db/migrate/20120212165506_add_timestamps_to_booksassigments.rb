class AddTimestampsToBooksassigments < ActiveRecord::Migration
  def change
    change_table :booksassigments do |t|
      t.timestamps
    end
  end
end
