class Book < ActiveRecord::Base
  has_many :booksassignments
  has_many :users, :through => :booksassignments
  # PaperClip gem for photos
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  # FriendlyId
  extend FriendlyId
  friendly_id :title, :use => :slugged
end
