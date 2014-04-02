class Topic < ActiveRecord::Base
  has_many :posts  # topic.posts
  default_scope { order('post_count DESC') }

  def post_increment
   self.post_count = self.posts.count
   self.save
  end

end
