class Booksassigment < ActiveRecord::Base
  belongs_to :user  # foreign key - user_id
  belongs_to :book  # foriegn key - book_id

  validates_presence_of :book_id, :user_id

  attr_accessible :user_id, :book_id;

  def set_assigment(user_id, book_id)
    self.user_id = user_id
    self.book_id = book_id
  end

  def self.get_user_book(user_id, book_id)
    where(:user_id => user_id, :book_id => book_id).first
  end

  def self.new_assigment(user_id, book_id)
    self.create(:user_id => current_user.id, :book_id => @book.id)
  end

end
