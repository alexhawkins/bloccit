class Post < ActiveRecord::Base
  #the has_many method tells Rails that a Post can havy many
  #comments related to is
  has_many :comments # post.comments
  belongs_to :user  #  user.post 
  belongs_to :topic  # topic.post
  mount_uploader :image, PostImagesUploader
  #after_create :increment_counter
  #Order the post by their created_at date, in descending order
  # displays the most recent posts first
  
  #set unique scope methods for various post sorting orders
  default_scope { order('created_at DESC') }
  scope :popular, -> { order('views DESC').limit(10) }
  scope :latest, -> { order('created_at DESC').limit(10) }
  scope :author, -> { order('created_at DESC').limit(10) }
  

  

  validates :title, length: { minimum: 5 }, presence: true 
  validates :body, length: {minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  def increment (by = 1)
    self.views ||= 0
    self.views += by
    self.save
  end
end
