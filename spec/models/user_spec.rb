#This block will run before each test. This is a great way 
#to setup variables for tests and keep things DRY. 
#Remember to use instance variables in the before blocks so
#you can access your variables outside of before.

require 'spec_helper'

describe User do

  describe ".top_rated" do
    before :each do
      post = nil
      topic = create(:topic)
      @u0 = create(:user) do |user|
        post = user.posts.build(attributes_for(:post))
        post.topic = topic
        post.save
        c = user.comments.build(attributes_for(:comment))
        c.post = post
        c.save
      end

      @u1 = create(:user) do |user|
        c = user.comments.build(attributes_for(:comment))
        c.post = post
        c.save
        post = user.posts.build(attributes_for(:post))
        post.topic = topic
        post.save
        c = user.comments.build(attributes_for(:comment))
        c.post = post
        c.save
      end
    end

    it "should return users based on comments + posts" do
      User.top_rated.should eq([@u1, @u0])
    end
    it "should have `posts_count` on user" do
      users = User.top_rated
      users.first.posts_count.should eq(1)
    end
    it "should have `comments_count` on user" do
      users = User.top_rated
      users.first.comments_count.should eq(2)
    end
  end

end