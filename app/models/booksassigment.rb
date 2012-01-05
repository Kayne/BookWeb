class Booksassigment < ActiveRecord::Base
  belongs_to :user  # foreign key - user_id
  belongs_to :book  # foriegn key - book_id

  validates_presence_of :book_id, :user_id

  def set_assigment(user_id, book_id)
    self.user_id = user_id
    self.book_id = book_id
  end

  def set_assigment_and_save(user_id, book_id)
    set_assigment(user_id, book_id)
    save
  end

  def self.get_user_book(user_id, book_id)
    where(:user_id => user_id, :book_id => book_id).first
  end

end
