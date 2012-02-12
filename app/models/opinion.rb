class Opinion < ActiveRecord::Base
  has_many :books
  has_many :users

  validates_presence_of :title, :text
  validates_length_of :title, :minimum => 4
  validates_length_of :text, :minimum => 4

  paginates_per 5

end
