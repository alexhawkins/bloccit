class Topic < ActiveRecord::Base
  has_many :posts  # topic.posts
  default_scope { order('post_count DESC') }

  def post_increment
   self.post_count = self.posts.count
   self.save
  end

  def popular(count = 10)
    order('popularity_score DESC').limit(count)
  end

end
