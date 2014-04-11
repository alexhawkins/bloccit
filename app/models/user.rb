class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :posts, dependent: :destroy #user.posts
  has_many :comments  #user.comments
  # A vote/favorite  post should not exist without a User
  # To account for this, we need to make sure to destroy
  # the associated vote/favorite if the user is destroyed
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  #after_create :populate_image

  def role?(base_role)
    role == base_role.to_s
  end

  def populate_image
    if avatar.blank? 
      avatar = "/path/to/default/image.jpg"
      user.save
    end
  end
#The favorited method takes a post object and returns a favorite 
#object if the post argument has an associated record in the 
#favorites table. If there is no favorite for the given post and 
#user, the method will return nil. This method will allow us to 
#toggle favorite / unfavorite links in the posts#show view.
  def favorited(post)
    self.favorites.where(post_id: post.id).first
  end
#The voted method takes a post object and returns a vote object
#if the post argument has an associated record in the votes table.
#it looks in votes where post_id = the id number of the post and
#gets the first element stored in that particular array. nil if 
#if the array is empty. Empty if no votes have been cast.
  def voted(post)
    self.votes.where(post_id: post.id).first
  end

 def self.top_rated
    self.select('users.*'). # Select all attributes of the user
        select('COUNT(DISTINCT comments.id) AS comments_count'). # Count the comments made by the user
        select('COUNT(DISTINCT posts.id) AS posts_count'). # Count the posts made by the user
        select('COUNT(DISTINCT comments.id) + COUNT(DISTINCT posts.id) AS rank'). # Add the comment count to the post count and label the sum as "rank"
        joins(:posts). # Ties the posts table to the users table, via the user_id
        joins(:comments). # Ties the comments table to the users table, via the user_id
        group('users.id'). # Instructs the database to group the results so that each user will be returned in a distinct row
        order('rank DESC') # Instructs the database to order the results in descending order, by the rank that we created in this query. (rank = comment count + post count)
  end

  ROLES = %w[member moderator admin]
end
