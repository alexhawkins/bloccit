class Post < ActiveRecord::Base
  #the has_many method tells Rails that a Post can havy many
  #comments related to is
  has_many :comments
  belongs_to :user
  belongs_to :topic
  #Order the post by their created_at date, in descending order
  # displays the most recent posts first
  default_scope { order('created_at DESC') }
end
