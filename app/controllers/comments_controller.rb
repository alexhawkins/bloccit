class CommentsController < ApplicationController
  #this enables the controller to respond to both html and js
  respond_to :html, :js
  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments

    @comment = current_user.comments.build(params.require(:comment).permit(:body, :post_id))
    @comment.post = @post
    #we can render a new _form partial, with a new instance of a comment. 
    #We'll start by adding this new instance variable to the comments 
    #controller. This will enable us to clear our comments form and get
    #the comment count correct.
    @new_comment = Comment.new
     #see comment policies to see the rules for authorization
    authorize @comment

    if @comment.save
      flash[:notice] = "Comment was created."
    else
      flash[:error] = "There was an error saving the comment. Please try again."
    end
    #remove redirect_to when using Ajax
    #redirect_to [@topic, @post]
    respond_with(@comment) do |f|
      f.html { redirect_to [@topic, @post] }
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])

    @comment = @post.comments.find(params[:id])
     #see policies to see the rules for authorization
    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment was removed."
      #remove redirect_to when using Ajax
      #redirect_to [@topic, @post]
    else
      flash[:error] = "Comment couldn't be deleted. Try again."
      #remove redirect_to when using Ajax
      #redirect_to [@topic, @post]
    end
    # By passing a block to respond_with you can overwrite what to do 
    # for a particular request format. In this case we are overwriting 
    # the default behavior for an HTML request
    respond_with(@comment) do |f|
      f.html { redirect_to [@topic, @post] }
    end

  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end
end