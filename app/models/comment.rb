class Comment < ActiveRecord::Base
  belongs_to :post   #user.post
  belongs_to :user  #user.commment
  

  # Makes sure that comments are at least 5 characters and the body
  # is always present
  validates :body, length: {minimum: 5}, presence: true
  validates :user, presence: true

  after_create :send_favorite_emails
  #After a comment is created we call send_favorite_emails. This method
  #grabs the post, finds all of the favorites associated with it and loops 
  #over them. For each favorite, it will create and send a new email.
  
  private

  def send_favorite_emails
    # for every favorite associated with post, send email
    self.post.favorites.each do |fav|
      # If this isn't the person who made the comment AND they want to get emails for favorites
      if fav.user_id != self.user_id && fav.user.email_favorites?
        FavoriteMailer.new_comment(fav.user, self.post, self).deliver
      end
    end
  end
end