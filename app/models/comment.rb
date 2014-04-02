class Comment < ActiveRecord::Base
  belongs_to :post

  # after_create :increment_counter

  # def increment_counter
  #   post.comment_count += 1
  #   post.save!
  # end
end
