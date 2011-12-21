class CreateBooksTable < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title,   :unique => true, :null => false
      t.text   :desc,    :null => false
      t.string :author,  :null => false
      t.string :photo,   :null => false
    end
  end
end
