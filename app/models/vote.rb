class Vote < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  # If value is anything other than 1 or -1, then a message will be returned to the user.
  validates :value, inclusion: { in: [-1, 1], message: "%{value} is not a valid vote." }
end
