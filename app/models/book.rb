class Book < ActiveRecord::Base
  has_many :booksassignments
  has_many :users, :through => :booksassignments
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
