class Opinion < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  validates_presence_of :title, :text
  validates_length_of :title, :minimum => 4
  validates_length_of :text, :minimum => 4

  paginates_per 5

end
