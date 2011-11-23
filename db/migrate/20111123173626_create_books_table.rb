class CreateBooksTable < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.text   :desc
      t.string :author
      t.string :photo
    end
  end
end
