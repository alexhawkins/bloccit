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
end
