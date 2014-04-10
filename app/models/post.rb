class Post < ActiveRecord::Base
  #the has_many method tells Rails that a Post can have many
  #comments related to it. Comments are dependent upon posts
  # so if a post is destroyed, we need to make sure to delete
  # all comments associated with that post too.
  has_many :comments, dependent: :destroy # post.comments
  # A post has many votes, but if a post is destroyed
  # the votes for that post need to be destroyed as well
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user  #  user.post 
  belongs_to :topic  # topic.post
  #It's safe to assume that if a user submits a post, they'll 
  #want to vote it up. We'll do this automatically for them by 
  #adding another after_create. See create vote private method
  #below.
  after_create :create_vote
  mount_uploader :image, PostImagesUploader
  #after_create :increment_counter
  #Order the post by their created_at date, in descending order
  # displays the most recent posts first
  def up_votes
    self.votes.where(value: 1).count
  end

  def down_votes
    self.votes.where(value: -1).count
  end

  def points
    self.votes.sum(:value).to_i
  end
  
  #set unique scope methods for various post sorting orders
  #Since we want the largest rank numbers displayed first,
  # we'll use descending (DESC) order to the default post sort
  #method to sort by rank
  default_scope { order('rank DESC') }
  scope :visible_to, ->(user) { user ? scoped : joins(:topic).where('topics.public' => true) }
  #scope :rank, -> { order('rank DESC') }
  scope :popular, -> { order('views DESC').limit(10) }
  scope :latest, -> { order('created_at DESC').limit(10) }
  scope :author, -> { order('created_at DESC').limit(10) }
  #scope :votes, -> { order(')}

  
  #validates each post title to make sure it meets the following 
  #conditons.If it does not, it returns the appropriate errors
  validates :title, length: {
    minimum: 5,
    maximum: 75,
    too_short: "must have at least 5 characters",
    too_long: "must have less than 75 characters",
    presence: true 
  }

  validates :body, length: {minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  def increment (by = 1)
    self.views ||= 0
    self.views += by
    self.save
  end
#Determine the age of the post by subtracting a standard time 
#from its created_at time. A standard time in this context is 
#known as an epoch. This gives us an age in seconds. By doing 
#this, newer posts start with a higher ranking, and the relative 
#ranking of older posts will decay over time

#1)Divide the age (currently in seconds) by the number of seconds
#in a day (86,400). This gives us the age in days;
#2)Add the points (i.e. sum of the votes) to the age. This means 
#that the passing of one day will be equivalent to one down vote;
#3)Finally, update the post's rank attribute with the new_rank 
#calculated by the algorithm.

def update_rank
  age = (self.created_at - Time.new(1970,1,1)) / 86400
  new_rank = points + age

  self.update_attribute(:rank, new_rank)
end

private 
  #defualt votes: automatically upvote post for user upon creation
   def create_vote
    user.votes.create(value: 1, post: self)
  end

end
