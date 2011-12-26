class Book < ActiveRecord::Base
  has_many :booksassigments, :dependent => :destroy
  has_many :users, :through => :booksassigments
  
  validates_presence_of :title, :desc, :author
  validates_uniqueness_of :title
  validates_length_of :title, :minimum => 4
  validates_length_of :author, :minimum => 4

  attr_readonly :title

  paginates_per 3

  # PaperClip gem for photos
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  # FriendlyId
  extend FriendlyId
  friendly_id :title, :use => :slugged
end
