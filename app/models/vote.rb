class Vote < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  # If value is anything other than 1 or -1, then a message will be returned to the user.
  validates :value, inclusion: { in: [-1, 1], message: "%{value} is not a valid vote." }
  after_save :update_post
  #The after_save method will run update_post every time a vote is saved. 
  #The update_post method calls a method named update_rank on a vote's post object
  private

  def update_post
    self.post.update_rank
  end

end
