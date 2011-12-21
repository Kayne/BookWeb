class AddPhotoForPaperclip < ActiveRecord::Migration
  def change
    remove_column :books, :photo
    add_column :books, :photo_file_name,    :string,   :null => false
    add_column :books, :photo_content_type, :string,   :null => false
    add_column :books, :photo_file_size,    :integer,  :null => false
    add_column :books, :photo_updated_at,   :datetime, :null => false
  end
end
