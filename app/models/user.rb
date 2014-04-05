class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :posts    #user.posts
  has_many :comments  #user.comments
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
