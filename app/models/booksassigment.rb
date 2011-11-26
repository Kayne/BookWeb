class Booksassigment < ActiveRecord::Base
  belongs_to :user  # foreign key - user_id
  belongs_to :book  # foriegn key - book_id
end
