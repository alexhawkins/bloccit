class Comment < ActiveRecord::Base
  belongs_to :post   #user.post
  belongs_to :user  #user.commment

  # after_create :increment_counter

  # def increment_counter
  #   post.comment_count += 1
  #   post.save!
  # end
  # Makes sure that comments are at least 5 characters and the body
  # is always present
  validates :body, length: {minimum: 5}, presence: true
end
