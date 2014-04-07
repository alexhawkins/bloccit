class Post < ActiveRecord::Base
  #the has_many method tells Rails that a Post can have many
  #comments related to it. Comments are dependent upon posts
  # so if a post is destroyed, we need to make sure to delete
  # all comments associated with that post too.
  has_many :comments, dependent: :destroy # post.comments
  # A post has many votes, but if a post is destroyed
  # the votes for that post need to be destroyed as well
  has_many :votes, dependent: :destroy
  belongs_to :user  #  user.post 
  belongs_to :topic  # topic.post
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
  default_scope { order('created_at DESC') }
  scope :popular, -> { order('views DESC').limit(10) }
  scope :latest, -> { order('created_at DESC').limit(10) }
  scope :author, -> { order('created_at DESC').limit(10) }
  #scope :votes, -> { order(')}

  
  #validates each post title to make sure it meets the following conditons.
  #If it does not, it returns the appropriate errors
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

end
