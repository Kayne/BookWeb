class Booksassigment < ActiveRecord::Base
  belongs_to :user  # foreign key - user_id
  belongs_to :book  # foriegn key - book_id

  validates_presence_of :book_id, :user_id

  def set_user_and_book_id(user_id, book_id)
    self.user_id = user_id
    self.book_id = book_id
  end

  def self.get_first_book(user_id, book_id)
    where(:user_id => user_id, :book_id => book_id).first
  end

end
