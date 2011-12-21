class AddSlugFieldInBooksTable < ActiveRecord::Migration
  def change
    add_column :books, :slug, :string, :null => false
    add_index :books, :slug, :unique => true
  end
end
