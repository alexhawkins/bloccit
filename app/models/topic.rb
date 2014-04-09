class Topic < ActiveRecord::Base
  #depended: :destroy will delete any dependent posts when a topic
  # is deleted. This is important since if we delete a topic, posts
  # belonging to that topic won't know where to go(unless we specifically
  # delte them) and they will have nothingto belong to anymore.
  has_many :posts, dependent: :destroy # topic.posts

  #sorts the posts based on post_count database value
  default_scope { order('post_count DESC') }

  #changes scope so that is shows only public topics.
  #scope :visible_to, -> { where(public: true) }

  #changes scope so it only shows public topics and private topics
  #if the user that created the topic is signed in
  scope :visible_to, ->(user) { user ? scoped : where(public: true) }

  def post_increment
   self.post_count = self.posts.count
   self.save
  end

  def popular(count = 10)
    order('popularity_score DESC').limit(count)
  end

end
