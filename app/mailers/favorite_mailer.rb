class FavoriteMailer < ActionMailer::Base
  default from: "alexhawkins.me@gmail.com"

#This is the method you'll call in order to send an email 
#to someone about their favorite posts:
  def new_comment(user, post, comment)
    @user = user
    @post = post
    @comment = comment

    # New Headers
      headers["Message-ID"] = "<comments/#{@comment.id}@bloccit.example>"
      headers["In-Reply-To"] = "<post/#{@post.id}@ybloccit.example>"
      headers["References"] = "<post/#{@post.id}@ybloccit.example>"

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end