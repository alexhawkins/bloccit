class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :posts, dependent: :destroy #user.posts
  has_many :comments  #user.comments
  # A vote should not exist without a Useer so to
  # account for this, we need to make sure to destroy
  # the associated vote if the user is destroyed
  has_many :votes, dependent: :destroy
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
end
