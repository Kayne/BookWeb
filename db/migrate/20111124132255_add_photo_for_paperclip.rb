class AddPhotoForPaperclip < ActiveRecord::Migration
  def change
    remove_column :books, :photo
    add_column :books, :photo_file_name,    :string
    add_column :books, :photo_content_type, :string
    add_column :books, :photo_file_size,    :integer
    add_column :books, :photo_updated_at,   :datetime
  end
end
