class VotesController < ApplicationController
  #Since you are using a before_filter, the setup method will be called before 
  #every other method in votes_controller.rb, thus setting the proper instance 
  #variables for each vote.
  before_filter :setup

  def down_vote
    update_vote(-1)
    redirect_to :back
  end

  def up_vote
    update_vote(1)
    redirect_to :back
  end

  private

  def setup
    #grab the parent objects @topic and @post
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    #looks for an exitsing vote by this person so we don't create multiple
    @vote = @post.votes.where(user_id: current_user.id).first
  end

  def update_vote(new_value)
    if @vote # if it exists, update it
      authorize @vote, :update?
      @vote.update_attribute(:value, new_value)
    else # create it
      @vote = current_user.votes.build(value: new_value, post: @post)
      authorize @vote, :create?
      @vote.save
    end
  end

end