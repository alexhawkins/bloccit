class PostsController < ApplicationController
  def show
    @topic = Topic.find(params[:topic_id])
    #see topic policies to see the rules for this authorization
    #we need to authorize the topic to make sure it's not a private
    #topic, otherwise we will end up showing posts belonging to topics that
    #are supposed to be private. Obviously this would upset the user
    #which is not good. Nope.
    authorize @topic
    @post = Post.find(params[:id])
    @post.increment
    @id = @post.id
    ## Saves user_id of post author and allows us
    ## to retrieve all of said author's posts at a later time
    ## by comparing the saved @user_id to all posts with
    ## that same id. ex:
    ## Post.all.each { |post| if @user_id == post.user_id }
    @user_id = @post.user_id
    @comments = @post.comments
    @comment = Comment.new
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    #see policies to see the rules for authorization
    authorize @post
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    #see policies to see the rules for authorization
    authorize @post
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(post_params)
    @post.topic = @topic
     #see policies to see the rules for authorization
    authorize @post
    if @post.save
      @topic.post_increment
      redirect_to [@topic, @post], notice: "Post was saved successfully."
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    #see policies to see the rules for authorization
    authorize @post
    if @post.update_attributes(post_params)
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])

    title = @post.title
    #see policies to see the rules for authorization
    authorize @post
    if @post.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to @topic
    else
      flash[:error] = "There was an error deleting the post."
      render :show
    end
  end

  private 

  def post_params
    params.require(:post).permit(:title, :body, :image, :topic_id)
  end
end





