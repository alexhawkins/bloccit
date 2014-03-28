class Post < ActiveRecord::Base
  #the has_many method tells Rails that a Post can havy many
  #comments related to is
  has_many :comments
end
