 # create_table "votes", force: true do |t|
 #    t.integer  "value"
 #    t.integer  "post_id"
 #    t.integer  "user_id"
 #    t.datetime "created_at"
 #    t.datetime "updated_at"
 #  end

require 'spec_helper'

describe Vote do

  describe "#up_vote?" do
    it "returns true for an up vote" do
      v = Vote.new(value: 1)
      v.up_vote?.should be_true
    end

    it "returns false for a down vote" do
      v = Vote.new(value: -1)
      v.up_vote?.should be_false
    end
  end

  describe "#down_vote?" do
    it "returns true for a down vote" do
      v = Vote.new(value: -1)
      v.down_vote?.should be_true
    end

    it "returns false for a down vote" do
      v = Vote.new(value: 1)
      v.down_vote?.should be_false   
    end
  end

  describe "#update_post" do
    it "calls `update_rank` on post" do
      user = create(:user)
      post = create(:post)
      post.should respond_to(:update_rank)
      post.should_receive(:update_rank)
      Vote.create(value: 1, post: post, user: user)
    end
  end

  it "should to a user" do
    user = create(:user)
    v = Vote.new(value: 1, user: user)
    v.user.should_not be_nil
  end

  it "should belong to a post" do
    post = create(:post)
    v = Vote.new(value: 1, post: post)
    v.post.should_not be_nil
  end

end