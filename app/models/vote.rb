class Vote < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  # If value is anything other than 1 or -1, then a message will be returned to the user.
  validates :value, inclusion: { in: [-1, 1], message: "%{value} is not a valid vote." }
  validates_presence_of :post, :user
  after_save :update_post
  #The after_save method will run update_post every time a vote is saved. 

  #We are calling our up_vote and down_vote methods below in _voter.html.erb to determine
  #if the voted class should be used to style or thumbs up/down glyphicon. Check database 
  #for 1 if upvote, -1 for down_vote
  def up_vote?
    value == 1
  end

  def down_vote?
    value == -1
  end

  #The update_post method calls a method named update_rank on a vote's post object
  private

  def update_post
    self.post.update_rank
  end


end
