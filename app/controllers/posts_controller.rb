class PostsController < ApplicationController
  def index
    #shows posts with the most views cretated within the last seven days.
    #Get rid of unscoped and popular if you want to show highest ranked posts within
    #the last seven days. NOTE: using unscoped gets rid of the default scope so
    #you can apply default scoping.
   # @posts = Post.unscoped.popular.visible_to(current_user).where("posts.created_at > ?",30.days.ago).paginate(page: params[:page], per_page: 10)
   @posts = Post.visible_to(current_user).where("posts.created_at > ?",30.days.ago).paginate(page: params[:page], per_page: 10)
  end
end
