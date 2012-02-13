class Opinion < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  validates_presence_of :title, :text
  validates_length_of :title, :minimum => 4
  validates_length_of :text, :minimum => 4
  validates :rate, :numericality => {:minimum => 1, :maximum => 6}

  paginates_per 5

  def self.add_new_opinion(book_id, user_id, title, text)
    self.create(:book_id => book_id, :user_id => user_id, :title => title, :text => text)
  end
end
